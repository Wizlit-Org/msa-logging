NAMESPACE ?= mysql

.PHONY: install_mysql
install_mysql: create_ns  ## Install Keycloak DB
	helm repo add bitnami https://charts.bitnami.com/bitnami && \
	helm repo update && \
	helm upgrade --install mysql bitnami/mysql \
		-n $(NAMESPACE) \
	 	--create-namespace \	
		--set auth.rootPassword=$(MYSQL_ROOT_PASSWORD) \
		--set auth.database=$(MYSQL_DATABASE) \
		--set auth.username=$(MYSQL_USER) \
		--set auth.password=$(MYSQL_PASSWORD)
