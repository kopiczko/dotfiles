brew: brew-bundle brew-post

brew-bundle:
	brew bundle

brew-up:
	brew update
	brew upgrade
	brew cleanup

brew-post: BREW_PREFIX=$(shell brew --prefix)
brew-post:
	$(BREW_PREFIX)/opt/fzf/install --completion --key-bindings --update-rc --no-fish
