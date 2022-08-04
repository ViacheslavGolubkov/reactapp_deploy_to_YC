terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
  }

  provider "yandex" {
  token     = "AQAAAAAGr2zaAATuwUg_9EhAK0mPh1LjHE9LSVk"
  cloud_id  = "b1g2593k11ai4j2fpude"
  folder_id = "b1gnlcb1hiv9e03692tv"
  zone      = "ru-central1-a"
  }

  resource "yandex_vpc_network" "network-1" {
  name = "network-1"
  }

  resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  }

  resource "yandex_compute_instance" "vm-1" {
  name = "test"
  platform_id = "standard-v1"
  zone = "ru-central1-a"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host = "${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
    agent = false
  }

  resources {
    cores = 2
    memory = 2
  }

  provisioner "file" {
    source = "./user_data.sh"
    destination = "/home/ubuntu/user_data.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ~/user_data.sh",
      "sudo ~/user_data.sh",
    ]
  }

  boot_disk {
    initialize_params {
      image_id = "fd87tirk5i8vitv9uuo1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

  resource "yandex_compute_instance" "vm-2" {
  name = "test-2"
  platform_id = "standard-v1"
  zone = "ru-central1-a"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host = "${yandex_compute_instance.vm-2.network_interface.0.nat_ip_address}"
    agent = false
  }

  resources {
    cores = 2
    memory = 2
  }

  provisioner "file" {
    source = "./user_data.sh"
    destination = "/home/ubuntu/user_data.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ~/user_data.sh",
      "sudo ~/user_data.sh",
    ]
  }

  boot_disk {
    initialize_params {
      image_id = "fd87tirk5i8vitv9uuo1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
  resource "yandex_compute_instance" "vm-3" {
  name = "haproxy"
  platform_id = "standard-v1"
  zone = "ru-central1-a"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host = "${yandex_compute_instance.vm-3.network_interface.0.nat_ip_address}"
    agent = false
  }

  resources {
    cores = 2
    memory = 2
  }

  # provisioner "file" {
  #   source = "./user_data.sh"
  #   destination = "/home/ubuntu/user_data.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo chmod +x ~/user_data.sh",
  #     "sudo ~/user_data.sh",
  #   ]
  # }

  boot_disk {
    initialize_params {
      image_id = "fd87tirk5i8vitv9uuo1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

 resource "yandex_compute_instance" "vm-4" {
  name = "reactjs"
  platform_id = "standard-v1"
  zone = "ru-central1-a"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host = "${yandex_compute_instance.vm-4.network_interface.0.nat_ip_address}"
    agent = false
  }

  resources {
    cores = 2
    memory = 2
  }

  # provisioner "file" {
  #   source = "./user_data.sh"
  #   destination = "/home/ubuntu/user_data.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo chmod +x ~/user_data.sh",
  #     "sudo ~/user_data.sh",
  #   ]
  # }

  boot_disk {
    initialize_params {
      image_id = "fd87tirk5i8vitv9uuo1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

  output "external_ip_address_reactjs" {
  description = "My external IP"
  value = yandex_compute_instance.vm-4.network_interface.0.nat_ip_address
  }


  output "internal_ip_address_" {
  description = "My external IP"
  value = yandex_compute_instance.vm-4.network_interface.0.ip_address
  }



  output "internal_instance_ip" {
  description = "My internal IP"
  value = [yandex_compute_instance.vm-1.network_interface.0.ip_address
  ,yandex_compute_instance.vm-2.network_interface.0.ip_address]
  }


  output "external_ip_address_vm_1" {
  description = "My external IP"
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
  }

  output "internal_ip_address_vm_2" {
  description = "My internal IP"
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
  }


  output "external_ip_address_vm_2" {
  description = "My external IP"
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
  }

  output "internal_ip_address_haproxy" {
  description = "My internal IP"
  value = yandex_compute_instance.vm-3.network_interface.0.ip_address
  }


  output "external_ip_address_haproxy" {
  description = "My external IP"
  value = yandex_compute_instance.vm-3.network_interface.0.nat_ip_address
  }
