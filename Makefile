.PHONY: default
default: help

.PHONY: links
## links: create symlinks
links:
	@echo "====> $@"
	./install.sh

.PHONY: brew
## brew: brew-up brew-bundle brew-post
brew: brew-up brew-bundle brew-post

.PHONY: brew-bundle
## brew-bundle: calls "brew bundle"
brew-bundle: .sudo
	@echo "====> $@"
	sudo true # So it doesn't ask later on.
	brew bundle

.PHONY: brew-up
## brew-bundle: update, upgrade and cleanup brew
brew-up: .sudo
	@echo "====> $@"
	sudo true # So it doesn't ask later on.
	brew update
	brew upgrade
	brew cleanup

.PHONY: brew-post
## brew-post: runs manual actions after installing brew packages
brew-post: BREW_PREFIX := $(shell brew --prefix)
brew-post: /usr/local/bin/helm /usr/local/bin/helm2 /usr/local/bin/helm3
	@echo "====> $@"
	@echo "----> Setup python"
	brew link --overwrite python@2
	brew link --overwrite python
	@echo "----> Update completions for fzf"
	$(BREW_PREFIX)/opt/fzf/install --completion --key-bindings --update-rc --no-fish
	@echo "----> Set font rendering for Alacritty"
	defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
	@echo "----> Allow natural key press-and-hold" 
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

/usr/local/bin/helm: /usr/local/bin/helm3
	@echo "====> $@"
	ln -s $< $@

/usr/local/bin/helm2:
	@echo "====> $@"
	ln -s $(shell brew --prefix)/opt/helm@2/bin/helm $@

/usr/local/bin/helm3:
	@echo "====> $@"
	ln -s $(shell brew --prefix)/opt/helm@3/bin/helm $@


.PHONY: completions
## completions: setup completions for various commands
completions: dir := ~/.config/zsh/funcs_ephemeral
completions:
	@echo "====> $@"
	opsctl completion zsh > $(dir)/_opsctl
	gsctl completion zsh --stdout > $(dir)/_gsctl
	rm -f ~/.zcompdump
	@echo
	@echo '----> Now run "compinit" from your shell'

.PHONY: .sudo
.sudo:
	@echo "====> $@"
	sudo true # So it doesn't ask later on.

.PHONY: help
## help: prints this help message
help:
	@echo "Usage:"
	@echo
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
