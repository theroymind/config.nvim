return {
    "tpope/vim-fugitive",
    config = function()
        -- Map '<leader>gs' to open Fugitive status window and track previous buffer
        vim.keymap.set("n", "<leader>gs", ":Git <CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>gb", ":Git blame <CR>", { noremap = true, silent = true })

        -- Create autocommand group for Fugitive
        local Eroy_Fugitive = vim.api.nvim_create_augroup("eroy_fugitive", {})
        vim.api.nvim_create_autocmd("OptionSet", {
            group = Eroy_Fugitive,
            pattern = "diff",
            callback = function()
                if vim.wo.diff then
                    local bufnr = vim.api.nvim_get_current_buf()
                    -- Key mappings for diff view
                    vim.keymap.set("n", "<C-d>", "]c", { noremap = true, silent = true, buffer = bufnr })
                    vim.keymap.set("n", "<C-u>", "[c", { noremap = true, silent = true, buffer = bufnr })
                    vim.keymap.set("n", "<leader>gU", ":Git checkout %<CR>",
                        { noremap = true, silent = true, buffer = bufnr })
                    vim.keymap.set("n", "<leader>gu", ":Git checkout -p %<CR>",
                        { noremap = true, silent = true, buffer = bufnr })
                end
            end,
        })

        -- Autocommand to handle settings when entering a Fugitive buffer
        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = Eroy_Fugitive,
            pattern = "*",
            callback = function()
                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)

                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({ 'pull', '--rebase' })
                end, opts)

                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
                vim.keymap.set("n", "<leader>gU", ":Git checkout %<CR>",
                    { noremap = true, silent = true, buffer = bufnr })
                vim.keymap.set("n", "<leader>gu", ":Git checkout -p<CR>",
                    { noremap = true, silent = true, buffer = bufnr })
            end,
        })

        -- Key mappings for diffget
        vim.keymap.set("n", "gf", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gj", "<cmd>diffget //3<CR>")
    end
}
