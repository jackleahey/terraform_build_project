## Project Overview

This project is a modular, production-inspired AWS infrastructure environment built with Terraform and HCP Terraform. It was designed to provide hands-on experience with Infrastructure as Code (IaC), AWS networking, identity and access management, secure compute deployment, and Git-based infrastructure workflows.

The environment currently includes a custom VPC with public and private subnets across multiple Availability Zones, route tables, an Internet Gateway, optional NAT Gateway functionality, security groups, IAM roles and instance profiles, and a private Amazon Linux EC2 instance. The infrastructure is organized into reusable Terraform modules for networking, security, IAM, and compute.

HCP Terraform provides remote state management and executes infrastructure plans and applies. Authentication between HCP Terraform and AWS uses OIDC and temporary credentials rather than long-lived AWS access keys. Infrastructure changes are developed through feature branches and GitHub pull requests, allowing HCP Terraform speculative plans to validate changes before they are merged and applied.

Cost and security were considered throughout the design. The Linux EC2 instance is deployed without a public IP address and is intended to be administered through AWS Systems Manager Session Manager. NAT Gateway functionality is optional and disabled when outbound connectivity is not required.

While the initial Terraform infrastructure is largely complete, this repository is intended to continue evolving as a cloud engineering sandbox. The existing AWS environment will provide the foundation for hands-on Linux administration, configuration management with Ansible, application development with Go, CI/CD, monitoring and auditing, and eventually containerization with Docker and other infrastructure technologies as needed.
