BREW := $(shell command -v brew 2> /dev/null)
CONFIG_DIR := ~/.config/nvim

all: check-brew install-neovim install-ripgrep install-prettierd

check-brew:
ifndef BREW
	@echo "Homebrew is not installed. Installing Homebrew..."
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@echo "Homebrew is already installed."
endif

install-neovim:
ifdef BREW
	@echo "Installing Neovim using Homebrew..."
	brew install neovim
else
	@echo "Homebrew installation failed. Cannot proceed with Neovim installation."
endif

install-ripgrep:
ifdef BREW
	@echo "Installing ripgrep using Homebrew..."
	brew install ripgrep
else
	@echo "Homebrew installation failed. Cannot proceed with ripgrep installation."
endif

install-prettierd:
ifdef BREW
	@echo "Installing prettierd using Homebrew..."
	brew install fsouza/prettierd/prettierd
else
	@echo "Homebrew installation failed. Cannot proceed with prettierd installation."
endif

.PHONY: all check-brew install-neovim install-ripgrep install-prettierd
