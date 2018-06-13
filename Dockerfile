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
	install -o ansible -g ansible -m 0755 -d /home/ansible/data && \
	install -o ansible -g ansible -m 0700 -d /home/ansible/.ssh && \
	echo "Host *\n\tUserKnownHostsFile ~/data/.ssh_known_hosts" > /home/ansible/.ssh/config && \
	chown ansible:ansible /home/ansible/.ssh/config

ENTRYPOINT [ "/usr/bin/ansible" ]
WORKDIR "/home/ansible/data"
USER ansible

# when running: mount
#  - ansible configuration -> /etc/ansible
#  - playbooks and other stuff -> /home/ansible/data
