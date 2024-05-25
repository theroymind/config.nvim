# Installation
Checkout this repo and then running `make` will automatically install some dependencies through brew and then copy the nvim config into ~/.config/nvim.

```
make
```

This uses lazy vim, neovim runs the root init.lua to setup. This also runs the `lua/eroy/init.lua` which bootstraps `lazy_init.lua` and all the dependencies autoload from the `lazy` directory.

If you want to add a new plugin and hook it into the lazy setup, simply add a new lua file for it and it'll automatically get loaded.


Some global commands are setup in `lua/eroy/init.lua`. The rest are typically found within their plugin lua file in the `lazy` directory.

Vim configurations are done in the `lua/eroy/set.lua`

General remaps are done in `lua/eroy/remap.lua` while plugin specific are typically done in their respective files. The only exception is the LSP keymaps are done in the `lua/eroy/init.lua`.

## Colors
The default color scheme is Nord, you can see/add color schemes in

`lua/eroy/lazy/colors.lua`

You can change the color scheme calling:
:lua ColorMyPencils("neofusion")


## Icons In nvim-tree
### Download the Nerd Font:

Visit the Nerd Fonts website.

Download the JetBrains Mono Nerd Font.

Install the Font:


Locate the downloaded ZIP file and unzip it.

Find the TTF files within the unzipped folder.

Double-click each TTF file and click "Install Font" in the preview window that appears.

Configure Your Terminal:


Set your terminal emulator to use the installed Nerd Font.
