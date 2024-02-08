# aws ec2 describe-images --owners amazon  --filters "Name=name,Values=amzn2-ami-kernel-5.10-hvm-2.0.2022*" --region us-west-1  --output table

data "aws_iam_policy_document" "s3_web" {
  statement {

    effect    = "Allow"
    actions   = [ 
      "s3:Get*",
      "s3:List*"
      ]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_instance_profile" "goat" {
  name = "goat_profile"
  role = aws_iam_role.goat.id
}

resource "aws_iam_role" "goat" {
  name        = "Goat_role"
  description = "IAM web instance profile for bad servers"
  path        = "/"

  assume_role_policy = data.aws_iam_policy_document.assume_role_ec2.json
}

resource "aws_iam_role_policy_attachment" "ssm_goat_ec2" {
  role       = aws_iam_role.goat.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "ssm_core_goat_ec2" {
  role       = aws_iam_role.goat.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_patch_goat_ec2" {
  role       = aws_iam_role.goat.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
}

resource "aws_iam_role_policy_attachment" "goat_admin" {
  role       = aws_iam_role.goat.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
