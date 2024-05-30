return {
    "prettier/vim-prettier",
    config = function()
        -- Enable autoformatting if config file is present
        vim.g['prettier#autoformat_config_present'] = 1
        vim.g['prettier#autoformat'] = 1
        vim.g['prettier#autoformat_require_pragma'] = 0

        -- Use prettierd instead of prettier
        vim.g['prettier#exec_cmd_path'] = 'prettierd'

        -- Define the file patterns for Prettier
        local file_patterns = { "*.js", "*.jsx", "*.mjs", "*.ts", "*.tsx", "*.css", "*.less", "*.scss", "*.json",
            "*.graphql", "*.md", "*.vue", "*.svelte", "*.yaml", "*.html", "*.php" }

        -- Convert the file patterns to a string separated by commas
        local file_pattern_string = table.concat(file_patterns, ",")

        -- Set up autocommand to run PrettierAsync on BufWritePre for specific file types
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            pattern = file_pattern_string,
            command = "PrettierAsync"
        })
    end
}
