
NAMESPACE ?= keycloak

create_ns:
	kubectl create ns $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -

.PHONY: create_keycloak_secret
create_keycloak_secret: create_ns ## Apply Keycloak Secrets from file
	kubectl apply -f ./keycloak/keycloak-admin-secret.yaml -n $(NAMESPACE)
	kubectl apply -f ./keycloak/keycloak-mysql-secret.yaml -n $(NAMESPACE)

.PHONY: delete_keycloak_secret
delete_keycloak_secret: ## Delete Keycloak Secrets
	kubectl delete -f ./keycloak/keycloak-admin-secret.yaml -n $(NAMESPACE) || true
	kubectl delete -f ./keycloak/keycloak-mysql-secret.yaml -n $(NAMESPACE) || true

install_keycloak: create_ns ## Install Keycloak
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo update
	helm upgrade --install keycloak bitnami/keycloak \
		-n $(NAMESPACE) \
		-f values-keycloak.yaml

.PHONY: deploy_keycloak ## Deploy Keycloak
deploy_keycloak: install_mysql create_keycloak_secret install_keycloak

.PHONY: remove_keycloak ## Undeploy Keycloak
remove_keycloak:
	helm uninstall keycloak -n $(NAMESPACE) || true
	helm uninstall mysql -n $(NAMESPACE) || true
	$(MAKE) delete_keycloak_secret
