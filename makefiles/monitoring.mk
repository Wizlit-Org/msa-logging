NAMESPACE = logging

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