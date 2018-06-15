FROM ubuntu:bionic

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

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
	chown root:root /usr/local/bin/entrypoint.sh && \
	chmod 0755 /usr/local/bin/entrypoint.sh && \
	cp -a /etc/ansible /var/ansible-distconfig

VOLUME [ "/home/ansible/data", "/etc/ansible" ]

USER ansible
WORKDIR "/home/ansible/data"
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

# when running: mount
#  - ansible configuration -> /etc/ansible
#  - playbooks and other stuff -> /home/ansible/data
