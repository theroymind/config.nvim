return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag"
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                "jsdoc", "bash", "php", "html", "php_only", "bash"
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            indent = {
                enable = true
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },
            autotag = {
                enable = true
            },
            fold = {
                enable = true
            }
        })

        local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            },
        }
        treesitter_parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade",
        }
        vim.filetype.add({
            pattern = {
                [".*%.blade%.php"] = "blade",
            },
        })

        vim.cmd [[
            augroup BladeFiletypeRelated
            autocmd!
            autocmd BufNewFile,BufRead *.blade.php set ft=blade
            augroup END
            ]]
        -- Enable folding based on Treesitter
        -- vim.opt.foldmethod = 'expr'
        vim.opt.foldmethod = 'indent'
        -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
        vim.opt.foldlevelstart = 99 -- Start with all folds open
        vim.opt.foldenable = false  -- Disable folding at startup
        vim.treesitter.language.register("templ", "templ")
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "vue",
            callback = function()
                vim.cmd('setlocal foldmethod=indent')
                vim.cmd('setlocal foldexpr=')
            end,
        })
    end
}
