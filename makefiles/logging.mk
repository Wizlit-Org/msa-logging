NAMESPACE = logging

.PHONY: deploy_alloy
deploy_alloy: set_secret ## Install Grafana Alloy (Grafana Cloud)
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo update
	helm upgrade --install alloy grafana/alloy \
	-n $(NAMESPACE) \
	--create-namespace \
	-f /tmp/alloy-override.yaml
	@rm -f /tmp/alloy-override.yaml

.PHONY: deploy_grafana_k8s_monitoring
deploy_grafana_k8s_monitoring: set_grafana_values ## Install grafana/k8s-monitoring (Grafana Cloud)
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo update
	helm upgrade --install \
	--version ^1 \
	--atomic \
	--timeout 300s grafana-k8s-monitoring grafana/k8s-monitoring \
	-n $(NAMESPACE) \
	--create-namespace \	
	-f /tmp/monitoring-override.yaml
	@rm -f /tmp/monitoring-override.yaml

.PHONY: set_secret
set_secret:
	@sed 's|<API_KEY>|$(ALLOY_API_KEY)|g' alloy/values-override.yaml > /tmp/alloy-override.yaml
	@sed 's|<API_KEY>|$(ALLOY_API_KEY)|g' kubernetes-monitoring/values-override.yaml > /tmp/monitoring-override.yaml
