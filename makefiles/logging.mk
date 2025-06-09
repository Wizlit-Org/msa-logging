NAMESPACE = logging

.PHONY: deploy_alloy
deploy_alloy: set_secret ## Install Grafana Alloy (Grafana Cloud)
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo update
	helm upgrade --install alloy grafana/alloy \
	-n $(NAMESPACE) \
	--create-namespace \
	-f /tmp/values-override.yaml
	@rm -f /tmp/values-override.yaml

.PHONY: set_secret
set_secret:
	@sed 's|<API Key>|$(ALLOY_API_KEY)|g' values-override.yaml > /tmp/values-override.yaml
