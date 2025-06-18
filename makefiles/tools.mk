.PHONY: install_k9s
install_k9s: ## Install latest k9s
	sudo mkdir -p /tmp/k9s
	K9S_VERSION=$$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | jq -r .tag_name); \
	curl -L https://github.com/derailed/k9s/releases/download/$${K9S_VERSION}/k9s_Linux_amd64.tar.gz -o /tmp/k9s_Linux_amd64.tar.gz; \
	sudo tar -xvzf /tmp/k9s_Linux_amd64.tar.gz -C /tmp/k9s; \
	sudo mv /tmp/k9s/k9s /usr/local/bin/; \
	sudo chmod +x /usr/local/bin/k9s
	@echo "K9s 설치 완료. 버전:"
	@k9s version

.PHONY: install_helm
install_helm: ## helm 설치
	@VERSION="v3.13.2" && \
	curl -LO https://get.helm.sh/helm-$${VERSION}-linux-amd64.tar.gz && \
	tar -zxvf helm-$${VERSION}-linux-amd64.tar.gz && \
	sudo mv linux-amd64/helm /usr/local/bin/helm && \
	rm -rf linux-amd64 helm-$${VERSION}-linux-amd64.tar.gz

start_minikube: ## Start Minikube
	minikube status
	minikube start --driver=none   --container-runtime=docker   --cri-socket=/var/run/cri-dockerd.sock
	minikube addons enable ingress