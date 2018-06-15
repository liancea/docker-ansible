#!/bin/bash
set -ue
# create link target for .ssh in data volume
if [[ ! -d ~/data/.ssh ]]; then
	install -o ansible -g ansible -m 0750 -d ~/data/.ssh
fi

# link .ssh directory to data volume, if not created otherwise (don't delete any data)
if [[ ! -a ~/.ssh ]]; then
	ln -s ~/data/.ssh ~/.ssh
fi

# # populate /etc/ansible volume if empty
if [[ -z "$(ls -A /etc/ansible)" ]]; then
	cp -Ta /var/ansible-distconfig /etc/ansible
fi

# goodnight
exec sleep infinity
