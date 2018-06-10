FROM ubuntu:bionic

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get -y install software-properties-common && \
	apt-add-repository ppa:ansible/ansible && \
	apt-get install -y ansible && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	adduser --disabled-password --gecos "" --home /home/ansible ansible && \
	install -o ansible -g ansible -m 0755 -d /home/ansible/playbooks

ENTRYPOINT [ "/usr/bin/ansible" ]
WORKDIR "/home/ansible/playbooks"
# when running: mount ansible hosts to /etc/ansible/hosts, config to /etc/ansible/ansible.cfg
