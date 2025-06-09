NAMESPACE = logging

.PHONY: deploy_alloy
deploy_alloy: create_ns ## Install Grafana Alloy (Grafana Cloud)
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo update
	helm upgrade --install alloy grafana/alloy \
	-n $(NAMESPACE) \
	--create-namespace \
	-f alloy/values-override.yaml

.PHONY: set_secretKey
set_secretKey:  ## Secret Key 적용
	sed 's|<API KEY>|$(ALLOY_API_KEY)|g' alloy/values-override-tmp.yaml > /alloy/values-override.yaml
