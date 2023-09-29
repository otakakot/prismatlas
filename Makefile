include .env
export

.PHONY: help
help: ## display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: up
up: ## docker compose up
	@docker compose --project-name prismatlas --file ./.docker/compose.yaml up -d

.PHONY: down
down: ## docker compose down
	@docker compose --project-name prismatlas down --volumes

.PHONY: balus
balus: ## destroy everything about docker. (containers, images, volumes, networks.)
	@docker compose --project-name prismatlas down --rmi all --volumes

.PHONY: psql
psql:
	@docker exec -it postgres psql -U postgres

.PHONY: migrate
migrate:
	@make atlasapply

.PHONY: doc
doc:
	@tbls doc $(DATABASE_URL) doc

.PHONY: prismastudio
prismastudio:
	@(cd schema && bun run prisma studio)

.PHONY: prismafmt
prismafmt:
	@(cd schema && bun run prisma format)

.PHONY: prismapush
prismapush:
	@(cd schema && bun run prisma db push)

.PHONY: prismapull
prismapull:
	@(cd schema && bun run prisma db pull)

.PHONY: atlasinspect
atlasinspect:
	@atlas schema inspect -u ${DATABASE_URL} > schema/schema.hcl

.PHONY: atlasapply
atlasapply:
	@atlas schema apply -u ${DATABASE_URL} --to file://schema/schema.hcl --auto-approve

.PHONY: atlasfmt
atlasfmt:
	@atlas schema fmt schema/schema.hcl
