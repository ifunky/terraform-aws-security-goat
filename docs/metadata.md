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

