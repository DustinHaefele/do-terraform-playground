resource "digitalocean_droplet" "web2" {
  image = "ubuntu-16-04-x64"
  name = "web2"
  region = "nyc3"
  size = "512mb"
  private_networking = true
  user_data= file(config/webuserdata.sh)
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    user = "root"
    type = "ssh"
    host     = "${digitalocean_droplet.web2.ipv4_address}"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
} 

