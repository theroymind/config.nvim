return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    name = "telescope",
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
            },
            defaults = {
                file_ignore_patterns = {
                    "node_modules/",
                    "%.git/",
                    "vendor/",
                    "tmp/",
                    "log/",
                    "%.min%.js",
                },
                layout_config = {
                    vertical = {
                        width = 0.95
                    },
                    horizontal = {
                        width = 0.95
                    },
                },
                path_display = {
                    "filename_first"
                },
                mappings = {
                    i = {
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
                        ["<leader>qf"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                    n = {
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
                        ["<leader>qf"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            }
        })

        require('telescope').load_extension('fzf')

        -- File finding and grep keybindings are in fzf.lua (fzf-lua)

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>qo', function()
            if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
                vim.cmd('cclose')
            else
                vim.cmd('copen')
            end
        end, { noremap = true, silent = true })

        -- Function to add an entry to the quickfix list
        local function add_to_quickfix(entry)
            vim.fn.setqflist({ entry }, 'a')
        end

        -- Function to remove entries from the quickfix list by filename
        local function remove_from_quickfix(filename)
            local qf_list = vim.fn.getqflist()
            local new_qf_list = {}
            for _, item in ipairs(qf_list) do
                if item.filename ~= filename then
                    table.insert(new_qf_list, item)
                end
            end
            vim.fn.setqflist(new_qf_list, 'r')
        end

        -- Key mappings to add and remove from quickfix list
        vim.keymap.set('n', '<leader>qa', function()
            local filename = vim.fn.expand("%:p")
            local line = vim.fn.line(".")
            local col = vim.fn.col(".")
            add_to_quickfix({
                filename = filename,
                lnum = line,
                col = col,
                text = "Added manually"
            })
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<leader>qd', function()
            local filename = vim.fn.expand("%:p")
            remove_from_quickfix(filename)
        end, { noremap = true, silent = true })


        -- Function to delete the current quickfix entry and echo a message
        function Delete_current_quickfix_entry()
            local qf_list = vim.fn.getqflist()
            local current_entry = vim.fn.line('.') -- Get the current entry's line number
            if current_entry <= #qf_list then
                table.remove(qf_list, current_entry)
                vim.fn.setqflist(qf_list, 'r')
                vim.cmd('echo "Quickfix entry removed"')
            else
                vim.cmd('echo "No entry to remove"')
            end
        end

        -- Autocommand to map 'dd' in the quickfix window
        vim.cmd([[
            augroup QuickfixMappings
                autocmd!
                autocmd FileType qf nnoremap <buffer> dd :lua Delete_current_quickfix_entry()<CR>
            augroup END
        ]])
    end
}
