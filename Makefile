# Makefile for common repo commands

.PHONY: help dvc-pull dvc-push dvc-status dvc-list sync-knowledge

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

dvc-pull: ## Pull data from DVC remote storage
	dvc pull

dvc-push: ## Push data to DVC remote storage
	dvc push

dvc-status: ## Check status of DVC files
	dvc status

dvc-list: ## List DVC-tracked files
	dvc list .

dvc-import-url: ## Import a remote URL into DVC tracked path (usage: make dvc-import-url URL=<url> DEST=<dest>)
	dvc import-url $(URL) $(DEST)

dvc-add: ## Add a file/directory to DVC tracking (usage: make dvc-add PATH=<path>)
	dvc add $(PATH)

dvc-commit: ## Commit DVC changes
	dvc commit
