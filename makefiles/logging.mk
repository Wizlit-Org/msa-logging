NAMESPACE ?= logging

.PHONY: deploy_alloy
deploy_alloy: create_ns ## Install Grafana Alloy (Grafana Cloud)
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo update
	helm upgrade --install alloy grafana/alloy \
	-n $(NAMESPACE) \
	--create-namespace \	
	-f values-override.yaml