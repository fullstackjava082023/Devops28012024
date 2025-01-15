# allow specific port:
ufw allow 22

# generat ssh key
ssh-keygen -t ed25519 -C "default"

# copy ssh key to remote server
ssh-copy-id -i ~/.ssh/id_ed25519.pub root@<your ip>
# username root
# password <your password> -> from linode

# establish ssh connection
ssh root@172.232.209.99


ansible-playbook site.yml --limit db-servers


  
  python3 --version
  pip3 --version
  sudo apt install python3-pip
  sudo apt install python3-venv
  
# encrypt password
  openssl passwd -6 'arja'
