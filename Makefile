.DEFAULT_GOAL:=help
SHELL:=/bin/bash

define run_docker
	$(if $(1), echo $(1), echo 'services list is not defined'; exit 1)
	docker-compose -f docker-compose.yml up "$1"
endef

define run_ansible
	$(if $(1), echo Using playbook $(1), echo 'playbook is not defined'; exit 1)
	ANSIBLE_CONFIG=infrastructure/ansible.cfg ansible-playbook -i infrastructure/credentials/inventory.ini infrastructure/$1
endef

all: help

run-services: ## Run all extended services (Postgres)
	@$(call run_docker,"postgres")

swarm-config: ## Run ansible playbook to deploy Swarm
	@$(call run_ansible,"main.yml")

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
