module "ec2_linux_vuln_ssh_password2" {
  count       = var.enabled ? 1 : 0  
  source = "git::https://github.com/ifunky/terraform-aws-ec2-instance?ref=main"

  ami             = "ami-09d3b3274b6c5d4aa" #data.aws_ami.linux_web_new.id
  iam_role        = aws_iam_instance_profile.goat.name
  instance_type   = "t3.micro"
  key_pair        = var.key_pair
  vpc_id          = var.vpc_id
  subnet          = var.subnet_id 
  security_groups = [aws_security_group.goat_cis_4_1[count.index].id, var.sg_tls_group_id]
  associate_public_ip_address = true
  name            = "IFAPP06"
  namespace       = "ifunky"

  metadata_options = {
      enabled                 = true
      require_session_tokens  = false # True = Use metadata service V2 False Don't
      http_hop_limit          = 1
  }

  ebs_block_device = [
            {
              device_name           = "/dev/sdh"
              volume_type           = "gp3"
              volume_size           = 5
              delete_on_termination = true
            },
            {
              device_name           = "/dev/sdj"
              volume_type           = "gp3"
              volume_size           = 5
              delete_on_termination = true
            },
    ]

  user_data       =<<EOF
set -e

# Mount devices
mkdir /opt/mount1
mkdir /opt/mount2
mkfs -t ext4 /dev/sdh
mkfs -t ext4 /dev/sdj
echo "/dev/sdh /opt/mount1 ext4 defaults,nofail 0 2" >> /etc/fstab
echo "/dev/sdj /opt/mount1 ext4 defaults,nofail 0 2" >> /etc/fstab
mount -a

amazon-linux-extras install epel -y
yum install sshpass polkit httpd php-5.4.16-46.amzn2.0.2.x86_64 -y

# Create local power user
# useradd -G wheel turbo
# echo "${var.ssh_password}" | passwd --stdin turbo

# Create test malicious malware file
echo 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*' > eicar.com

# Download more malware for testing (high severity)
curl -o /opt/mount1/eicar.com https://secure.eicar.org/eicar.com
curl -o /opt/mount1/eicar_com.zip https://secure.eicar.org/eicar_com.zip
curl -o /opt/mount1/eicar_com2.zip https://secure.eicar.org/eicar_com2.zip

#  High vulnerable package: https://docs.wiz.io/wiz-docs/docs/wiz-adv-2022-024
curl -Lo /tmp/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.8/aws-iam-authenticator_0.5.8_linux_amd64

# Text4Shell critical vulnerability: CVE-2022-42889
curl -Lo /tmp/commons-text-1.6-bin.tar.gz https://archive.apache.org/dist/commons/text/binaries/commons-text-1.6-bin.tar.gz
tar -xf /tmp/commons-text-1.6-bin.tar.gz -C /tmp

# Enable SSH passwords for testing - be VERY CAREFUL!!
sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config

sshd -t
systemctl restart sshd.service

EOF

  tags = {
    Project   = "B"
    Stage     = "Test"
  }
}

