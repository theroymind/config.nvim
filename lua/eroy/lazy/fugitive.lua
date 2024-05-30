return {
    "tpope/vim-fugitive",
    config = function()
        -- Track the previous buffer and Fugitive status window
        _G.previous_bufnr = nil
        _G.fugitive_status_winid = nil

        -- Function to open Fugitive status and track previous buffer
        function OpenFugitive()
            local current_buf = vim.api.nvim_get_current_buf()
            local bufname = vim.api.nvim_buf_get_name(current_buf)
            if bufname and bufname ~= "" then
                vim.cmd("mkview 1")
            end
            _G.previous_bufnr = current_buf
            vim.cmd.Git()
            _G.fugitive_status_winid = vim.api.nvim_get_current_win()
        end

        -- Function to close the diff view and return to the Fugitive status window
        function CloseDiffAndReturn()
            vim.cmd("q")
            if _G.fugitive_status_winid and vim.api.nvim_win_is_valid(_G.fugitive_status_winid) then
                vim.api.nvim_set_current_win(_G.fugitive_status_winid)
            end
        end

        -- Function to close Fugitive status window and return to the previous buffer with view restored
        function CloseFugitiveAndReturn()
            vim.cmd("q")
            if _G.previous_bufnr and vim.api.nvim_buf_is_valid(_G.previous_bufnr) then
                local bufname = vim.api.nvim_buf_get_name(_G.previous_bufnr)
                if bufname and bufname ~= "" then
                    vim.cmd("buffer " .. _G.previous_bufnr)
                    vim.cmd("loadview 1")
                else
                    vim.cmd("buffer " .. _G.previous_bufnr)
                end
            end
        end

        -- Map '<leader>gs' to open Fugitive status window and track previous buffer
        vim.keymap.set("n", "<leader>gs", ":lua OpenFugitive()<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>gb", ":Git blame", { noremap = true, silent = true })
        -- Map 'q' and 'Esc' to close the diff and return to the Fugitive status window if in diff view, else close Fugitive
        vim.keymap.set("n", "q", function()
            if vim.bo.ft == "fugitive" then
                CloseFugitiveAndReturn()
            else
                CloseDiffAndReturn()
            end
        end, { noremap = true, silent = true })

        vim.keymap.set("n", "<Esc>", function()
            if vim.bo.ft == "fugitive" then
                CloseFugitiveAndReturn()
            else
                CloseDiffAndReturn()
            end
        end, { noremap = true, silent = true })

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
                if vim.wo.diff then
                    local bufnr = vim.api.nvim_get_current_buf()
                    -- Key mappings for diff view
                    vim.keymap.set("n", "<leader>gU", ":Git checkout %<CR>",
                        { noremap = true, silent = true, buffer = bufnr })
                    vim.keymap.set("n", "<leader>gu", ":Git checkout -p<CR>",
                        { noremap = true, silent = true, buffer = bufnr })
                end
                if vim.bo.ft ~= "fugitive" then
                    return
                end

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
