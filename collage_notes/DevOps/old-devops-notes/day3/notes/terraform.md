# Terraform

## installation

```bash

# macOS
> brew tap hashicorp/tap
> brew install hashicorp/tap/terraform

# linux
> wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
> echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
> sudo apt update
> sudo apt install terraform

# windows
> https://releases.hashicorp.com/terraform/1.14.0/terraform_1.14.0_windows_amd64.zip

# verify installation
> terraform --version

```

## CS Code extensions

- https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform

- https://marketplace.visualstudio.com/items?itemName=HashiCorp.HCL
