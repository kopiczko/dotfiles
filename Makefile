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
brew-bundle: BREW_PREFIX := $(shell brew --prefix)
brew-bundle: .sudo
	@echo "====> $@"
	brew install -q binutils coreutils findutils gnu-sed
	brew link -q --overwrite binutils
	brew install -q bash bash-completion
	brew install -q zsh zsh-autosuggestions zsh-syntax-highlighting
	brew install -q tmux reattach-to-user-namespace
	brew install -q git git-delta gitleaks gh
	brew install -q ctags htop watch wget tree
	brew install -q the_silver_searcher jq yq
	brew install -q fzf
	$(BREW_PREFIX)/opt/fzf/install --completion --key-bindings --update-rc --no-fish
	brew install -q node corepack
	corepack enable
	corepack prepare pnpm@latest --activate
	brew install -q python
	brew link -q --overwrite python
	brew install -q ruby
	brew install -q go
	brew install -q neovim
	brew install -q awscli azure-cli
	brew install -q helm kind kubectx kustomize
	brew install -q ansible terraform
	brew install -q vault
	brew install -q youtube-dl
	brew bundle

.PHONY: brew-up
## brew-bundle: update, upgrade and cleanup brew
brew-up: .sudo
	@echo "====> $@"
	brew update
	brew upgrade
	brew cleanup

.PHONY: brew-post
## brew-post: runs manual actions after installing brew packages
brew-post: BREW_PREFIX := $(shell brew --prefix)
brew-post: /usr/local/bin/helm /usr/local/bin/helm2 /usr/local/bin/helm3
	@echo "====> $@"
	@echo "----> Setup node pnpm"
	@echo "----> Update completions for fzf"
	@#echo "----> Set font rendering for Alacritty"
	@#defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
	@echo "----> Allow natural key press-and-hold"
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
	@echo "----> Setup dock size and Rectangle app"
	defaults write com.apple.dock tilesize -int 40
	killall Dock
	#defaults write com.knollsoft.Rectangle screenEdgeGapTop -int -4
	#defaults write com.knollsoft.Rectangle screenEdgeGapLeft -int -57
	#killall Rectangle && open /Applications/Rectangle.app

/usr/local/bin/helm:
	@echo "====> $@"
	ln -s $< $@

/usr/local/bin/helm2:
	@echo "====> $@"
	ln -s $(shell brew --prefix)/opt/helm@2/bin/helm $@

/usr/local/bin/helm3:
	@echo "====> $@"
	ln -s $(shell brew --prefix)/opt/helm/bin/helm $@


.PHONY: completions
## completions: setup completions for various commands
completions: dir := ~/.config/zsh/funcs_ephemeral
completions:
	@echo "====> $@"
	opsctl completion zsh > $(dir)/_opsctl
	gsctl completion zsh --stdout > $(dir)/_gsctl
	devctl completion zsh > $(dir)/_devctl
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
