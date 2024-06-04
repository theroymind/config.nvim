return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    name = "telescope",
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({ defaults = {
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
        }})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>qo', function()
            if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
                vim.cmd('cclose')
            else
                vim.cmd('copen')
            end
        end, { noremap = true, silent = true })
    end
}

