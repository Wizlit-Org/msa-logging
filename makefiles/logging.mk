.PHONY deploy_alloy
deploy_alloy:

	@helm repo add grafana https://grafana.github.io/helm-charts && \
	helm repo udpate && \
	helm install --namespace <NAMESPACE> <RELEASE_NAME> grafana/alloy