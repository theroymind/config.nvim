return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "tsserver",
                "volar",
                "tailwindcss",
                --"phpactor"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        underline = true,
                        virtual_text = {
                            severity_limit = "Warning"
                        }
                    }
                end,
                -- ["vuels"] = function()
                --     local lspconfig = require("lspconfig")
                --     lspconfig.vuels.setup {
                --         cmd = { "vls" },
                --         filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                --         settings = {
                --             vetur = {
                --                 useWorkspaceDependencies = false,
                --                 validation = {
                --                     template = true,
                --                     style = true,
                --                     script = true,
                --                 },
                --
                --                 experimental = {
                --                     templateInterpolationService = true,
                --                 },
                --             },
                --         },
                --     }
                -- end,
                ["tsserver"] = function()
                    local vue_language_server_path = require('mason-registry').get_package('vue-language-server')
                        :get_install_path() .. '/node_modules/@vue/language-server'
                    require("lspconfig").tsserver.setup {
                        init_options = {
                            plugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    location = vue_language_server_path,
                                    languages = { 'vue' },
                                },
                            },
                        },
                        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                    }
                end,
                ["volar"] = function()
                    require("lspconfig").volar.setup {}
                end,
                ["phpactor"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.phpactor.setup {
                        filetypes = { "php", "blade" }
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        -- Setup completion for command-line mode
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

        -- Setup completion for search mode (e.g., "/")
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
