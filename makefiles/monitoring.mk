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
deploy_grafana_k8s_monitoring: ## Install grafana/k8s-monitoring (Grafana Cloud)
	$(call helm_full_install, \
		grafana-k8s-monitoring, \
		grafana, \
		https://grafana.github.io/helm-charts, \
		grafana/k8s-monitoring, \
		kubernetes-monitoring/values-override.yaml, \
		$(NAMESPACE), \
		--version ^1 --atomic --timeout 300s \
	)