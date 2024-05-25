return {
    "prettier/vim-prettier",
    config = function()
       vim.g['prettier#autoformat_config_present'] = 1        -- Define the file patterns
        local file_patterns = { "*.js", "*.jsx", "*.mjs", "*.ts", "*.tsx", "*.css", "*.less", "*.scss", "*.json", "*.graphql", "*.md", "*.vue", "*.svelte", "*.yaml", "*.html" }
        -- Set up autocommand to run PrettierAsync on InsertLeave for specific file types
        vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
            pattern = file_patterns,
            command = "PrettierAsync"
        })
    end
}
