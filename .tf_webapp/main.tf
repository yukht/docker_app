variable "my_network" {
  # Variable settings see in credentials.auto.tfvars
  description = "network settings"
  type        = map(string)
}

module "network_ansible" {
  source                 = "./modules/network"
  network_description    = "Создание подсети для клиентов ansible"
  network_name           = "ansible-servers-subnet"
  network_id             = var.my_network["current_network"] # from credentials.auto.tfvars
  folder_id              = var.my_provider["folder"]         # from credentials.auto.tfvars
  network_zone           = var.my_network["zone_a"]          # from networks.auto.tfvars
  network_v4_cidr_blocks = ["10.128.1.0/27"]
}


module "key_vm_all_automation" {
  source        = "./modules/keys"
  key_srv_name  = "vm_all"
  key_user_name = "ansible"
}

# Notice! This example REQUIRES the creation of two users for each new machine. This need is caused by the 'srv' module code! #


# TEMPORARY VM1 minimal for docker (active)

module "key_vm1_default" {
  source        = "./modules/keys"
  key_srv_name  = "vm1"
  key_user_name = "admin"
}


module "vm1" {
  source           = "./modules/srv"
  srv_family       = "ubuntu-2204-lts"                      #
  srv_default_user = "admin"                                # default ssh user
  srv_second_user  = "ansible"                              # second ssh user for automation
  srv_key1         = module.key_vm1_default.ssh_key_v       # default ssh user public key
  srv_key2         = module.key_vm_all_automation.ssh_key_v # second ssh user public key
  srv_name         = "vm1"
  srv_description  = "vm1 docker"
  srv_zone         = var.my_network["zone_a"] # from networks.auto.tfvars
  # use standard-v3 for 50% core_fraction and standard-v1 (Intel Broadwell) for minumim server price (with 20% core_fraction) #
  srv_platform_id   = "standard-v1"
  srv_core_fraction = "20"
  srv_cores         = 2
  srv_memory        = 2
  srv_disk_size     = 10 # Size of the disk in GB
  srv_subnet        = module.network_ansible.created_id
  srv_ip            = "10.128.1.10"
  srv_nat           = "true" # If you create a balancer, an external address is needed!
}

# save public ip to file (TODO: replace to template)
resource "local_file" "srv1_public_ip" {
  content  = module.vm1.public_address
  filename = "server_data/vm1_public_ip"
}

# save private ip to file (TODO: replace to template)
resource "local_file" "srv1_private_ip" {
  content  = module.vm1.private_address
  filename = "server_data/vm1_private_ip"
}





