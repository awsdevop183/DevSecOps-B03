Adhoc commands

ansible -i inventory -m ping
ansible -i inventory -m setup ( we can get details of nodes)
ansible -i invenroty -m shell -a "ls -l"

ansible-playbook -i invenroty sample-play.yml --syntax-check
ansible-playbook -i invenroty sample-play.yml --check (dry run = terraform plan)

ansible-playbook -i invenroty sample-play.yml ( to run playbook)



ansible default cfg files

/etc/ansbile/ansible.cfg


become = Run with root privileges

gather_facts = true


gather_facts
ansbible-config list
variables
loops
conditionals - when


Ansible-lint



register
lineinflile 
handlers - notify
command vs shell
Service
ignore_errors: yes


tags usage
ansible-vault

block: 
rescue: if any reason block fails, it's gonna run rescue module

always: it runs awalys








ansible-vault:

ansible-vault encrypt aws_creds
ansible-vault decrypt aws_creds
ansible-vault create aws_creds
ansible-vault encrypt_string 'Password' --name 'user_password'


ansible-vault



ansible-playbook
ansible





ansible-galaxy / roles(= terraform modules)


/etc/ssh/sshd_config










Error handling:
  failed_when
  changed_when
  ignore_errors
  block, rescue, always


ubuntu : apt apt-get, dpkg.  package.deb
amazon linx/centos: dnf, yum,    rpm

