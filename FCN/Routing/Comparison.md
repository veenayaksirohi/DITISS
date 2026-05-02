# 📡 RIP vs OSPF vs EIGRP — **Full Master Comparison Table**


Router With Lowest Hop count is preffered ==> RIP 



| **Parameter**               | **RIP**                             | **OSPF**                  | **EIGRP**                                  |
| --------------------------- | ----------------------------------- | ------------------------- | ------------------------------------------ |
| **Full Form**               | Routing Information Protocol        | Open Shortest Path First  | Enhanced Interior Gateway Routing Protocol |
| **Type**                    | Distance Vector                     | Link-State                | Hybrid                                     |
| **Algorithm**               | Bellman-Ford                        | Dijkstra (SPF)            | DUAL                                       |
| **Metric**                  | Hop Count                           | Cost                      | Composite Metric                           |
| **Metric Based On**         | Number of hops                      | Bandwidth                 | Bandwidth + Delay                          |
| **Maximum Hop Count**       | 15                                  | No limit                  | No fixed limit                             |
| **Hop 16 Means**            | Unreachable                         | Not applicable            | Not applicable                             |
| **Administrative Distance** | 120                                 | 110                       | 90 (Internal), 170 (External)              |
| **Protocol Number**         | UDP                                 | IP Protocol               | IP Protocol                                |
| **Port / Protocol No.**     | UDP 520                             | Protocol 89               | Protocol 88                                |
| **Update Type**             | Periodic                            | Triggered                 | Triggered                                  |
| **Update Timer**            | 30 sec                              | No fixed periodic         | No periodic                                |
| **Transport Method**        | UDP                                 | IP                        | IP                                         |
| **Multicast Address**       | 224.0.0.9 (RIPv2)                   | 224.0.0.5, 224.0.0.6      | 224.0.0.10                                 |
| **Classful/Classless**      | RIPv1: Classful<br>RIPv2: Classless | Classless                 | Classless                                  |
| **VLSM Support**            | RIPv2 Yes                           | Yes                       | Yes                                        |
| **CIDR Support**            | RIPv2 Yes                           | Yes                       | Yes                                        |
| **Convergence Speed**       | Slow                                | Fast                      | Very Fast                                  |
| **Network Size Support**    | Small                               | Large                     | Medium to Large                            |
| **Routing Table Type**      | Simple                              | Topology Database         | Multiple Tables                            |
| **Tables Used**             | Routing Table                       | LSDB + Routing Table      | Neighbor, Topology, Routing                |
| **Bandwidth Usage**         | High                                | Medium                    | Low                                        |
| **CPU Usage**               | Low                                 | High                      | Medium                                     |
| **Memory Usage**            | Low                                 | High                      | Medium                                     |
| **Load Balancing**          | Equal only                          | Equal only                | Equal + Unequal                            |
| **Unequal Load Balancing**  | No                                  | No                        | Yes                                        |
| **Loop Prevention**         | Split Horizon                       | SPF Tree                  | Feasible Successor                         |
| **Triggered Updates**       | Partial                             | Yes                       | Yes                                        |
| **Authentication Support**  | RIPv2 only                          | Yes                       | Yes                                        |
| **Area Concept**            | No                                  | Yes                       | No                                         |
| **Hierarchical Design**     | No                                  | Yes                       | Partial                                    |
| **DR / BDR Used**           | No                                  | Yes                       | No                                         |
| **Topology Knowledge**      | Limited                             | Full network view         | Partial view                               |
| **Best For**                | Small networks                      | Large enterprise networks | Enterprise networks                        |
| **Vendor Support**          | All vendors                         | All vendors               | Cisco (originally)                         |
| **IPv6 Support**            | RIPng                               | OSPFv3                    | EIGRP for IPv6                             |




