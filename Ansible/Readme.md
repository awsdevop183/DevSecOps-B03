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



/etc/ssh/sshd_config










Error handling:
  failed_when
  changed_when
  ignore_errors
  block, rescue, always


ubuntu : apt apt-get, dpkg.  package.deb
amazon linx/centos: dnf, yum,    rpm

