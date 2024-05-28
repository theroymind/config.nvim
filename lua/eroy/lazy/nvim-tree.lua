return {
    'kyazdani42/nvim-tree.lua',
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true
        require('nvim-tree').setup {
            auto_reload_on_write = true,
            disable_netrw = true,
            hijack_netrw = true,
            open_on_tab = false,
            hijack_cursor = false,
            update_cwd = true,
            diagnostics = {
                enable = true,
            },
            view = {
                width = 30,
                side = 'left',
            },
            renderer = {
                highlight_opened_files = "all",
            },
            update_focused_file = {
                enable = true
            }
        }

        vim.api.nvim_set_keymap('n', '<leader>pv', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
}
