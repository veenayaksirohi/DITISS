# Terraform

## VS code setup

- https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform
- https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform

## providers list

- https://registry.terraform.io/

## installation

```bash

# macOS
> brew tap hashicorp/tap
> brew install hashicorp/tap/terraform

# ubuntu
> wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
> echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
> sudo apt update && sudo apt install terraform

# windows
> https://releases.hashicorp.com/terraform/1.14.8/terraform_1.14.8_windows_amd64.zip

# verify installation
> terraform --version

```

## AWS access key and secret

- open AWS management console
- open IAM service
- create a user
  - name: terraform-user
  - Provide user access to the AWS Management Console: off
  - Permissions options: Attach policies directly
    - Permission Policies: AdministratorAccess
- create an access key for the user
  - select the require user (terraform-user)
  - open Security credentials tab
    - in access keys section, add a new access key
    - Use case: Command Line Interface (CLI)
  - once created, note down both access key and secret
- configure the Access key and secret
  - open ~/.bashrc file (vim ~/.bashrc)
  - define environment variables
    - export AWS_ACCESS_KEY_ID=
    - export AWS_SECRET_ACCESS_KEY=
    - export AWS_DEFAULT_REGION=ap-south-1

## commands

```bash

# initialize the provider
> terraform init

# plan the execution
> terraform plan

# apply the execution plan
> terraform apply

# destroy all the resources
> terraform destroy

```
