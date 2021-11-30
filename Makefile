.PHONY: start
start:
	vagrant up

.PHONY: log
log:
	vagrant up | tee vagrant.log 2>&1

.PHONY: ssh
ssh:
	vagrant ssh

.PHONY: rm
rm:
	vagrant destroy -f
