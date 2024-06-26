# Terraform AWS

> **_NOTE:_** Variables for use with this project are managed in Terraform Cloud (TF Cloud) workspaces via the [`meta`](../meta/readme.md) project.  This example takes into account that you are using Terraform Cloud.  If not, simply modify the provider.tf file to reflect your setup.

Terraform scripts for managing the resources associated with an indy node within a given AWS account.

# Cheat Sheet

## List Workspaces

```
terraform workspace list
```

## Switch Workspaces

```
terraform workspace select <workspace_name>
```

## Get Ansible Inventory

```
terraform output -raw ansible_inventory
```

## Refresh Output

```
terraform apply -refresh-only
```