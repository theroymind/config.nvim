return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({})

        -- Ensure parsers are installed
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                local installed = require("nvim-treesitter").get_installed()
                local wanted = {
                    "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust",
                    "jsdoc", "bash", "html", "css", "scss", "json", "yaml",
                }
                local to_install = {}
                for _, lang in ipairs(wanted) do
                    if not vim.list_contains(installed, lang) then
                        table.insert(to_install, lang)
                    end
                end
                if #to_install > 0 then
                    require("nvim-treesitter").install(to_install)
                end
            end,
            once = true,
        })

        vim.opt.foldmethod = 'indent'
        vim.opt.foldlevelstart = 99 -- Start with all folds open
        vim.opt.foldenable = false  -- Disable folding at startup
    end
}
