resource "null_resource" "cluster" {
  count = var.environment == "prod" ? 3 : 1
  provisioner "file" {
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"
    connection {
      type        = "ssh"
      host        = element(aws_instance.public-server.*.public_ip, count.index)
      user        = "ubuntu"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 700 /tmp/user-data.sh",
      "sudo /tmp/user-data.sh",
      "sudo apt-get update",
      "sudo apt-get install jq unzip -y",
    ]
    connection {
      type        = "ssh"
      host        = element(aws_instance.public-server.*.public_ip, count.index)
      user        = "ubuntu"
      private_key = file(var.private_key_path)
    }
  }
}
