return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        "JMarkin/nvim-tree.lua-float-preview",
    },
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        vim.opt.termguicolors = true

        -- setup nvim-tree FIRST, before float-preview requires the api
        require('nvim-tree').setup {
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")
                api.map.on_attach.default(bufnr)
                local FloatPreview = require("float-preview")
                FloatPreview.attach_nvimtree(bufnr)
            end,
            auto_reload_on_write = true,
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = false,
            sync_root_with_cwd = true,
            diagnostics = {
                enable = true,
            },
            renderer = {
                highlight_opened_files = "all",
            },
            filters = {
                dotfiles = false,
            },
            update_focused_file = {
                enable = true
            }
        }

        -- setup float-preview AFTER nvim-tree so api is hydrated
        require("float-preview").setup({
            toggled_on = false,
            wrap_nvimtree_commands = false,
            scroll_lines = 20,
            window = {
                style = "minimal",
                relative = "win",
                border = "rounded",
                wrap = false,
            },
            mapping = {
                down = { "<C-d>" },
                up = { "<C-e>", "<C-u>" },
                toggle = { "<Tab>" },
            },
            hooks = {
                pre_open = function(path)
                    local size = require("float-preview.utils").get_size(path)
                    if type(size) ~= "number" then
                        return false
                    end
                    local is_text = require("float-preview.utils").is_text(path)
                    return size < 5 and is_text
                end,
                post_open = function(bufnr)
                    return true
                end,
            },
        })

        vim.api.nvim_set_keymap('n', '<leader>pv', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
}
