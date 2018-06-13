FROM ubuntu:bionic

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get -y install software-properties-common && \
	apt-add-repository ppa:ansible/ansible && \
	apt-get install -y ansible vim less && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	adduser --disabled-password --gecos "" --home /home/ansible ansible && \
	install -o ansible -g ansible -m 0755 -d /home/ansible/data

ENTRYPOINT [ "/usr/bin/ansible" ]
WORKDIR "/home/ansible/data"
USER ansible

# when running: mount
#  - ansible hosts -> /etc/ansible/hosts
#  - ansible config -> /etc/ansible/ansible.cfg
#  - ansible roles -> /etc/ansible/roles
#  - playbooks and other stuff -> /home/ansible/data
