default:
	@echo 'Run "make links" or "make brew[{-bundle,-up,-post}]".'

links:
	./install.sh

brew-bundle:
	sudo true # So it doesn't ask later on.
	brew bundle

brew-up:
	sudo true # So it doesn't ask later on.
	brew update
	brew upgrade
	brew cleanup

brew-post: BREW_PREFIX=$(shell brew --prefix)
brew-post:
	sudo true # So it doesn't ask later on.
	$(BREW_PREFIX)/opt/fzf/install --completion --key-bindings --update-rc --no-fish

