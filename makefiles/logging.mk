NAMESPACE ?= logging

.PHONY deploy_alloy
deploy_alloy:
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo update
	helm upgrade --install alloy grafana/alloy \
	-n $(NAMESPACE) \
	-f values-override.yaml