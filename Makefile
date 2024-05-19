BREW := $(shell command -v brew 2> /dev/null)
CONFIG_DIR := ~/.config/nvim

all: check-brew install-neovim copy-config

check-brew:
ifndef BREW
	@echo "Homebrew is not installed. Installing Homebrew..."
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@echo "Homebrew is already installed."
endif

install-neovim:
ifdef BREW
	@echo "Installing Neovim and ripgrep using Homebrew..."
	brew install neovim ripgrep
else
	@echo "Homebrew installation failed. Cannot proceed with Neovim and ripgrep installation."
endif

copy-config:
	@echo "Copying configuration files to $(CONFIG_DIR)..."
	mkdir -p $(CONFIG_DIR)
	cp -r lazy-lock.json init.lua lua $(CONFIG_DIR)

.PHONY: all check-brew install-neovim copy-config
