resource "aws_instance" "public-server" {
  # count                       = length(var.public_cidr_block)
  count                       = var.environment == "prod" ? 3 : 1
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnet.*.id, count.index + 1)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-public-server-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }



}
# user_data = <<-EOF
#    #!/bin/bash
#    	sudo apt-get update
#    	sudo apt-get install -y nginx
#       sudo git clone https://github.com/saikiranpi/SecOps-game.git
#       sudo rm -rf /var/www/html/index.nginx-debian.html
#       sudo cp -r SecOps-game/index.html /var/www/html/
#    	echo "<h1>${var.vpc_name}-public-Server-${count.index + 1} >> /var/www/html/index.html
#    	sudo systemctl start nginx
#    	sudo systemctl enable nginx
#    EOF


