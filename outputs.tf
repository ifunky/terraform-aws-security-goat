# output "bucket_arn" {
#   description = "Bucket ARN"
#   value       =  var.enabled ? join("", aws_s3_bucket.default.*.arn) : ""
# }

# output "wiz_iam_role_arn" {
#   description = "Wiz IAM Role ARN"
#   value       =  var.enabled ? join("", aws_iam_role.wiz.*.arn) : ""
# }

