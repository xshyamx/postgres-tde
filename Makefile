.PHONY: start
start:
	vagrant up

log:
	vagrant up | tee vagrant.log 2>&1

ssh:
	vagrant ssh
    
