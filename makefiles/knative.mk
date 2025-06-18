NAMESPACE = knative-operator

.PHONY: deploy_knative_operator
deploy_knative_operator:
	@helm repo add knative-operator https://knative.github.io/operator && \
	helm repo update && \
	helm upgrade --install knative-operator knative-operator/knative-operator \
		-n knative-operator \
		--create-namespace

.PHONY: deploy_knative_cr
deploy_knative_cr:
	kubectl apply -f knative/knative-serving.yaml
	kubectl apply -f knative/knative-eventing.yaml