ARCH  ?= $(shell go env GOARCH)
OS    ?= $(shell go env GOOS)

BIN_DIR         := $(HOME)/.local/bin
OPT_DIR         := $(HOME)/.local/opt
ENV_FILE	:= $(HOME)/.envs_volatile
TMP_DIR_PREFIX  := /tmp/install

.PHONY: install-kubebuilder
install-kubebuilder: BIN      := kubebuilder
install-kubebuilder: VERSION  := 3.0.0-beta.1
install-kubebuilder: URL := https://github.com/kubernetes-sigs/kubebuilder/releases/download/v$(VERSION)/kubebuilder_$(OS)_$(ARCH)
install-kubebuilder: INSTALL_DIR := $(OPT_DIR)/$(BIN)@$(VERSION)
install-kubebuilder: $(OPT_DIR) ## Install kubebuilder v3.
	@echo "====> $@"
	# Clean up install dir.
	rm -rf $(INSTALL_DIR)
	mkdir -p $(INSTALL_DIR)/bin
	# Download.
	curl -fsSL '$(URL)' -o $(INSTALL_DIR)/bin/$(BIN)
	chmod +x $(INSTALL_DIR)/bin/$(BIN)
	# Install.
	rm -rf $(BIN_DIR)/$(BIN)
	ln -s $(INSTALL_DIR)/bin/$(BIN) $(BIN_DIR)/$(BIN)
	# Clean any v2 env vars leftovers.
	sed -i '/^export KUBEBUILDER_ASSETS=/d' $(ENV_FILE)

.PHONY: install-kubebuilder-v2
install-kubebuilder-v2: BIN      := kubebuilder
install-kubebuilder-v2: VERSION  := 2.3.2
install-kubebuilder-v2: URL := https://github.com/kubernetes-sigs/kubebuilder/releases/download/v$(VERSION)/kubebuilder_$(VERSION)_$(OS)_$(ARCH).tar.gz
install-kubebuilder-v2: TMP_DIR := $(TMP_DIR_PREFIX)_$(BIN)
install-kubebuilder-v2: INSTALL_DIR := $(OPT_DIR)/$(BIN)@$(VERSION)
install-kubebuilder-v2: $(OPT_DIR) ## Install kubebuilder v2.
	@echo "====> $@"
	# Clean up tmp dir.
	rm -rf $(TMP_DIR)
	mkdir -p $(TMP_DIR)
	# Download and unpack.
	curl -fsSL '$(URL)' -o $(TMP_DIR)/tarball.tar.gz
	tar -C $(TMP_DIR) --strip-components 1 -zxf $(TMP_DIR)/tarball.tar.gz
	# Clean up install dir.
	rm -rf $(INSTALL_DIR)
	mv $(TMP_DIR) $(INSTALL_DIR)
	# Remove old binary.
	rm -rf $(BIN_DIR)/$(BIN)
	# Link the new binary.
	ln -s $(INSTALL_DIR)/bin/$(BIN) $(BIN_DIR)/$(BIN)
	# Set post install environment variables.
	sed -i '/^export KUBEBUILDER_ASSETS=/d' $(ENV_FILE)
	echo 'export KUBEBUILDER_ASSETS="$(INSTALL_DIR)/bin"' >> $(ENV_FILE)

$(OPT_DIR):
	mkdir -p $(OPT_DIR)

clean: ## Clean temporary directories.
	rm -rf $(TMP_DIR_PREFIX)*

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk commands is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
