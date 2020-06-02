DOCKER_VERSION := $(shell docker --version 2>/dev/null)
DOCKER_COMPOSE_VERSION := $(shell docker-compose --version 2>/dev/null)

ENV_BROWSER_HYDRA_HOST ?= localhost
ENV_BROWSER_CONSUMER_HOST ?= localhost
ENV_BROWSER_IDP_HOST ?= localhost
ENV_BROWSER_OATHKEEPER_PROXY_HOST ?= localhost

# ENV_HYDRA_VERSION ?= v1.0.9
ENV_HYDRA_VERSION ?= v1.4.9
ENV_KETO_VERSION ?= v0.2.2-sandbox_oryOS.10
# ENV_OATHKEEPER_VERSION ?= dev
# ^ Use this when building a local docker image from the oathkeeper source
ENV_OATHKEEPER_VERSION ?= v0.38.2-beta.1
# ENV_OATHKEEPER_VERSION ?= v0.14.2_oryOS.10
ENV_LOGIN_CONSENT_VERSION ?= reveel-dev
# ENV_LOGIN_CONSENT_VERSION ?= v1.0.8

all:
ifndef DOCKER_VERSION
    $(error "command docker is not available, please install Docker")
endif
ifndef DOCKER_COMPOSE_VERSION
    $(error "command docker-compose is not available, please install Docker")
endif

export LOGIN_CONSENT_VERSION=${ENV_LOGIN_CONSENT_VERSION}
export HYDRA_VERSION=${ENV_HYDRA_VERSION}
export OATHKEEPER_VERSION=${ENV_OATHKEEPER_VERSION}
export KETO_VERSION=${ENV_KETO_VERSION}

export BROWSER_HYDRA_HOST=${ENV_BROWSER_HYDRA_HOST}
export BROWSER_CONSUMER_HOST=${ENV_BROWSER_CONSUMER_HOST}
export BROWSER_IDP_HOST=${ENV_BROWSER_IDP_HOST}
export BROWSER_OATHKEEPER_PROXY_HOST=${ENV_BROWSER_OATHKEEPER_PROXY_HOST}

print_versions:
		$(info Oathkeeper:    $(OATHKEEPER_VERSION))
		$(info Hydra:         $(HYDRA_VERSION))
		$(info Keto:          $(KETO_VERSION))
		$(info Login/Consent: $(LOGIN_CONSENT_VERSION))

build-dev:
		docker build -t oryd/hydra:dev ${GOPATH}/src/github.com/ory/hydra/
		docker build -t oryd/oathkeeper:dev ${GOPATH}/src/github.com/ory/oathkeeper/
		docker build -t oryd/keto:dev ${GOPATH}/src/github.com/ory/keto/

###

build-full-stack: print_versions
		cd full-stack; docker-compose build

start-full-stack: print_versions
		cd full-stack; docker-compose up -d

restart-full-stack:
		cd full-stack; docker-compose restart

rm-full-stack:
		cd full-stack; docker-compose kill
		cd full-stack; docker-compose rm -f

reset-full-stack: rm-full-stack start-full-stack
