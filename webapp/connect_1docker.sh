ssh-keygen -f "/root/.ssh/known_hosts" -R "10.128.1.10"
ssh -i ../../../vm_all-ssh_key_ansible.pem ansible@10.128.1.10
