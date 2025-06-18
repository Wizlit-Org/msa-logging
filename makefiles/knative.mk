NAMESPACE = knative-operator

.PHONY: deploy_knative
deploy_knative: ## knative 설치
	@helm repo add knative-operator https://knative.github.io/operator && \
	helm repo update && \
	helm upgrade --install knative-operator knative-operator/knative-operator \
	-n $(NAMESPACE) \
	--create-namespace