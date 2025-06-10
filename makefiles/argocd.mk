NAMESPACE = argocd

.PHONY: deploy_argocd
deploy_argocd: create_ns  ## argocd 설치
	helm repo add argo https://argoproj.github.io/argo-helm && \
	helm repo update && \
	helm upgrade --install argocd argo/argo-cd \
	-n $(NAMESPACE) \
	--create-namespace \
	-f argocd/values-override.yaml
	kubectl apply -f https://raw.githubusercontent.com/Wizlit-Org/msa-logging/refs/heads/main/argocd_apps/infra-environments.yaml