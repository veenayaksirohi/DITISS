# Amazon EKS infrastructure architecture

This diagram documents the infrastructure created by [`infra/terraform/eks`](../infra/terraform/eks/). It represents the current Terraform configuration, including its public-access settings and worker-node placement.

[Open the editable diagrams.net source](./eks-architecture.drawio)

```mermaid
flowchart TB
    ADMIN[Cluster administrator / CI] -->|HTTPS Kubernetes API| PUBLIC_EP

    subgraph AWS[AWS · us-east-1]
        direction TB

        subgraph MANAGED[AWS-managed EKS service]
            PUBLIC_EP[Public EKS endpoint<br/>allowed CIDRs: 0.0.0.0/0]
            CP[EKS managed control plane<br/>Kubernetes 1.36<br/>API_AND_CONFIG_MAP authentication]
            OIDC[OIDC provider<br/>IRSA enabled]
            CREATOR[Cluster creator<br/>administrator permission]
            PUBLIC_EP --> CP
            CP --- OIDC
            CP --- CREATOR
        end

        subgraph VPC[project-eks-vpc · 10.0.0.0/16]
            direction TB
            IGW[Internet Gateway]

            subgraph AZA[Availability Zone A]
                PUB_A[Public subnet<br/>10.0.4.0/24<br/>external ELB tag]
                PRIV_A[Private subnet<br/>10.0.1.0/24<br/>internal ELB tag]
                NAT[Single NAT Gateway]
                PUB_A --> NAT --> PRIV_A
            end

            subgraph AZB[Availability Zone B]
                PUB_B[Public subnet<br/>10.0.5.0/24<br/>external ELB tag]
                PRIV_B[Private subnet<br/>10.0.2.0/24<br/>internal ELB tag]
            end

            IGW --> PUB_A
            IGW --> PUB_B
            NAT --> PRIV_B

            subgraph CLUSTER_ATTACH[EKS cluster subnet attachment]
                ENI_A[Control-plane ENI<br/>private subnet A]
                ENI_B[Control-plane ENI<br/>private subnet B]
            end

            PRIV_A --- ENI_A
            PRIV_B --- ENI_B
            CP --> ENI_A
            CP --> ENI_B

            subgraph NODEGROUP[EKS managed node group]
                ASG[Desired 2 · minimum 1 · maximum 3]
                NODE_A[EC2 worker node<br/>t3.medium · AL2023<br/>public IPv4]
                NODE_B[EC2 worker node<br/>t3.medium · AL2023<br/>public IPv4]
                ASG --> NODE_A
                ASG --> NODE_B
            end

            PUB_A --- NODE_A
            PUB_B --- NODE_B
            ENI_A <--> NODE_A
            ENI_B <--> NODE_B

            SG[all_worker_management security group<br/>all protocols inbound: 0.0.0.0/0<br/>all protocols outbound: 0.0.0.0/0]
            SG --> NODE_A
            SG --> NODE_B

            SSM[Node IAM role<br/>AmazonSSMManagedInstanceCore]
            SSM --> NODE_A
            SSM --> NODE_B
        end
    end

    INTERNET[Internet] --> IGW

    classDef aws fill:#fff7ed,stroke:#f59e0b,color:#431407,stroke-width:1.5px;
    classDef network fill:#eff6ff,stroke:#3b82f6,color:#172554,stroke-width:1.2px;
    classDef eks fill:#ecfdf5,stroke:#10b981,color:#052e16,stroke-width:1.2px;
    classDef identity fill:#f5f3ff,stroke:#8b5cf6,color:#2e1065,stroke-width:1.2px;
    classDef warning fill:#fff1f2,stroke:#e11d48,color:#4c0519,stroke-width:1.8px;
    classDef external fill:#f8fafc,stroke:#64748b,color:#0f172a,stroke-width:1.2px;

    class CP,ASG,NODE_A,NODE_B,ENI_A,ENI_B eks;
    class VPC,IGW,PUB_A,PUB_B,PRIV_A,PRIV_B,NAT network;
    class OIDC,CREATOR,SSM identity;
    class PUBLIC_EP,SG warning;
    class ADMIN,INTERNET external;
```

## Architecture summary

- Terraform creates the VPC from `10.0.0.0/16` across two availability zones, with two public and two private `/24` subnets.
- The VPC module creates one shared NAT gateway. Private-subnet egress therefore depends on that single gateway and its availability zone.
- The EKS module attaches the cluster to the two private subnets. AWS places the control-plane networking interfaces in those subnets.
- Both public and private EKS API access are enabled. The public endpoint currently accepts connections from `0.0.0.0/0`.
- The managed node group overrides the cluster subnet selection and runs in the two public subnets. Nodes receive public IP addresses.
- The node group uses Amazon Linux 2023, `t3.medium` instances, a desired size of two, and a scaling range of one to three nodes.
- Public subnets are tagged for external load balancers; private subnets are tagged for internal load balancers.
- IRSA is enabled through the cluster OIDC provider. The worker-node IAM role also receives `AmazonSSMManagedInstanceCore`.
- DNS support, DNS hostnames, and public-IP mapping are enabled for the VPC.

## Security observations

The drawing intentionally includes the current permissive settings. For a production environment, restrict the EKS public endpoint to trusted CIDRs or use private access only, move worker nodes to private subnets, and replace the worker security group's unrestricted inbound rule with the minimum ports and sources required by EKS and the deployed workloads.
