NAMESPACE = kube-system

.PHONY: deploy_certmanager
deploy_certmanager: ## certmanager 설치
## kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.crds.yaml
	@helm repo add jetstack https://charts.jetstack.io && \
	helm repo update && \
	helm upgrade --install cert-manager jetstack/cert-manager \
	-n $(NAMESPACE) \
	-f certmanager/values-override.yaml