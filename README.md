

# terraform-aws-security-goat
 [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A collection of bad infrastructure designed to trigger and demo security issues.

## Features

### EC2

- Creates an EC2 instance
- SSH password - BE VERY CAREFUL!
- ECAR malware samples
- Instance metadata V1
- Packages with high vulnerabilities

### Security groups

- Creates 2 security groups designed to violate standards CIS 4.1 (open port 22) and CIS 4.2 (open RDP 3389)

### Example AWS IAM key and secret

- Keys to the castle example to test secret detection



## Usage
```hcl
module "bad_infra" {
    source = "git::https://github.com/ifunky/terraform-aws-security-goat.git?ref=main"

    enabled   = true
    key_pair  = aws_key_pair.server.key_name
    vpc_id    = module.vpc.vpc_id
    vpc_name  = module.vpc.name
    region    = var.region
    subnet_id = data.aws_subnet.public_1b.id
    sg_tls_group_id = aws_security_group.vpc_tls.id
  }  

```
> NOTE: Please use this at your own risk!!


## Makefile Targets
The following targets are available: 

```
auth                           WizCli authentication
createdocs/help                Create documentation help
polydev/createdocs             Run PolyDev createdocs directly from your shell
polydev/help                   Help on using PolyDev locally
polydev/init                   Initialise the project
polydev/validate               Validate the code
polydev/wizscan                Security validation
polydev                        Run PolyDev interactive shell to start developing with all the tools or run AWS CLI commands :-)
scan                           Scan code
```
# Module Specifics

Core Version Constraints:
* `>= 1.0`

Provider Requirements:
* **aws (`hashicorp/aws`):** `~> 4.0`

## Input Variables
* `enabled` (default `true`): Enable/disable module.
* `key_pair` (required): Key pair for servers
* `region` (required): Region
* `sg_tls_group_id` (required): TLS security group ID
* `subnet_id` (required): Ssubnet to place resources
* `tags` (default `{}`): Additional tags (e.g. map('BusinessUnit`,`XYZ`)
* `vpc_id` (required): VPC ID for resoures.
* `vpc_name` (required): Name of the VPC

## Managed Resources
* `aws_iam_instance_profile.goat` from `aws`
* `aws_iam_role.goat` from `aws`
* `aws_iam_role_policy_attachment.goat_admin` from `aws`
* `aws_iam_role_policy_attachment.ssm_core_goat_ec2` from `aws`
* `aws_iam_role_policy_attachment.ssm_goat_ec2` from `aws`
* `aws_iam_role_policy_attachment.ssm_patch_goat_ec2` from `aws`
* `aws_security_group.goat_cis_4_1` from `aws`
* `aws_security_group.goat_cis_4_2` from `aws`

## Data Resources
* `data.aws_iam_policy_document.assume_role_ec2` from `aws`
* `data.aws_iam_policy_document.s3_web` from `aws`

## Child Modules
* `ec2_linux_vuln_ssh_password2` from `git::https://github.com/ifunky/terraform-aws-ec2-instance?ref=main`




## Related Projects

Here are some useful related projects.

- [PolyDev](https://github.com/ifunky/polydev) - PolyDev repo and setup guide





## References

For more information please see the following links of interest: 


# terraform-aws-security-goat
