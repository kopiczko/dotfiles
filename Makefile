.PHONY: default
default: help

.PHONY: links
links:
	./install.sh

.PHONY: brew
## brew: brew-up brew-bundle brew-post
brew: brew-up brew-bundle brew-post

## brew-bundle: calls "brew bundle"
brew-bundle: .sudo
	@echo "====> $@"
	sudo true # So it doesn't ask later on.
	brew bundle

## brew-bundle: update, upgrade and cleanup brew
brew-up: .sudo
	@echo "====> $@"
	sudo true # So it doesn't ask later on.
	brew update
	brew upgrade
	brew cleanup

## brew-post: runs manual actions after installing brew packages
brew-post: BREW_PREFIX := $(shell brew --prefix)
brew-post:
	@echo "====> $@"
	$(BREW_PREFIX)/opt/fzf/install --completion --key-bindings --update-rc --no-fish
	@echo
	@echo "--> Set font rendering for Alacritty."
	defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

## completions: setup completions for various commands
completions: dir := ~/.config/zsh/funcs_ephemeral
completions:
	@echo "====> $@"
	opsctl completion zsh > $(dir)/_opsctl
	gsctl completion zsh --stdout > $(dir)/_gsctl
	rm -f ~/.zcompdump
	@echo
	@echo '--> Now run "compinit" from your shell.'

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
