return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        {
            "JMarkin/nvim-tree.lua-float-preview",
            lazy = true,
            -- default
            opts = {
                -- Whether the float preview is enabled by default. When set to false, it has to be "toggled" on.
                toggled_on = false,
                -- wrap nvimtree commands
                wrap_nvimtree_commands = false,
                -- lines for scroll
                scroll_lines = 20,
                -- window config
                window = {
                    style = "minimal",
                    relative = "win",
                    border = "rounded",
                    wrap = false,
                },
                mapping = {
                    -- scroll down float buffer
                    down = { "<C-d>" },
                    -- scroll up float buffer
                    up = { "<C-e>", "<C-u>" },
                    -- enable/disable float windows
                    toggle = { "<Tab>" },
                },
                -- hooks if return false preview doesn't shown
                hooks = {
                    pre_open = function(path)
                        -- if file > 5 MB or not text -> not preview
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
            },
        },
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true
        local nvimtree = require('nvim-tree')
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")
            api.config.mappings.default_on_attach(bufnr)
            local FloatPreview = require("float-preview")
            FloatPreview.attach_nvimtree(bufnr)
            -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', ':lua require("nvim-tree.api").node.open.edit()<CR>',
            --     { noremap = true, silent = true })
            -- vim.keymap.set('n', 'g?', api.tree.toggle_help, { noremap = true })
        end
        nvimtree.setup {
            on_attach = on_attach,
            auto_reload_on_write = true,
            disable_netrw = true,
            hijack_netrw = true,
            open_on_tab = false,
            hijack_cursor = false,
            update_cwd = true,
            diagnostics = {
                enable = true,
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
