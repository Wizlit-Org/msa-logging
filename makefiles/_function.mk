
# ───────────────────────────────────────────────────────
# 공통 Helm 설치 함수 정의 (envsubst + Helm)
# $(1): 릴리스 이름 (e.g. argocd)
# $(2): Helm 리포 이름 (e.g. argo)
# $(3): Helm 리포 URL (e.g. https://argoproj.github.io/argo-helm)
# $(4): 차트 이름 (e.g. argo/argo-cd)
# $(5): values-template.yaml 경로
# $(6): 네임스페이스
# $(7): 추가 Helm 플래그 (e.g. --version x.x.x --atomic)
# ───────────────────────────────────────────────────────
define helm_full_install
	@echo "🔧 envsubst 치환 및 Helm 설치: $(1)" && \
	export $(shell cat .env | xargs) && \
	@envsubst < $(5) > /tmp/tmp-$(1)-override.yaml && \
	helm repo add $(2) $(3) && \
	helm repo update && \
	helm upgrade --install $(1) $(4) \
	-n $(6) \
	--create-namespace \
	-f /tmp/tmp-$(1)-override.yaml \
	$(7) && \
	rm -f /tmp/tmp-$(1)-override.yaml
endef