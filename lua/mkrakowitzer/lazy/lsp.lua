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
            cmp_lsp.default_capabilities()
        )

        local wk = require("which-key")

        local wk = require("which-key")

        wk.setup({})

        wk.add({
            -- Normal-mode LSP + diagnostics
            { "<C-k>",      function() vim.lsp.buf.signature_help() end, desc = "Signature help",        mode = "n" },
            { "<leader>K",  vim.lsp.buf.hover,                           desc = "Show help hover",       mode = "n" },
            { "<leader>[d", vim.diagnostic.goto_prev,                    desc = "Previous diagnostic",   mode = "n" },
            { "<leader>]d", vim.diagnostic.goto_next,                    desc = "Next diagnostic",       mode = "n" },
            { "<leader>gd", vim.lsp.buf.definition,                      desc = "Go to definition",      mode = "n" },
            { "<leader>gi", vim.lsp.buf.implementation,                  desc = "Go to implementation",  mode = "n" },
            { "<leader>gr", vim.lsp.buf.references,                      desc = "Find references",       mode = "n" },
            { "<leader>gt", vim.lsp.buf.type_definition,                 desc = "Go to type definition", mode = "n" },
            { "<leader>r",  vim.lsp.buf.rename,                          desc = "Rename symbol",         mode = "n" },
        })

        -- Optional: group them under a <leader> “LSP” menu in the which-key popup
        wk.add({
            { "<leader>g",  group = "LSP Goto" },
            { "<leader>gd", desc = "Go to definition" },
            { "<leader>gi", desc = "Go to implementation" },
            { "<leader>gr", desc = "Find references" },
            { "<leader>gt", desc = "Go to type definition" },
            { "<leader>[d", group = "Diagnostics" },
            { "<leader>]d", desc = "Next diagnostic" },
            { "<leader>[d", desc = "Prev diagnostic" },
            { "<leader>K",  group = "Hover/Help" },
            { "<leader>K",  desc = "Show help hover" },
            { "<leader>r",  group = "Refactor" },
            { "<leader>r",  desc = "Rename symbol" },
        })

        require("fidget").setup({})

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "ansiblels",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities, -- make sure 'capabilities' is defined (e.g. via cmp_nvim_lsp)
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" }, -- or "LuaJIT" for Neovim
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Enter>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        -- Diagnostics config
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        require("lspconfig").gopls.setup({
            on_attach = function(client, bufnr)
                require("lsp-inlayhints").setup({
                    inlay_hints = {
                        parameter_hints = { prefix = "in: " }, -- "<- "
                        type_hints = { prefix = "out: " }      -- "=> "
                    }
                })
                require("lsp-inlayhints").on_attach(client, bufnr)
                require("illuminate").on_attach(client)
            end,
            settings = {
                -- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
                gopls = {
                    analyses = {
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true
                    },
                    experimentalPostfixCompletions = true,
                    gofumpt = true,
                    -- staticcheck = true,
                    usePlaceholders = true,
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true
                    }
                }
            }
        })
        require("lspconfig").ansiblels.setup({
            filetypes = {
                "yaml", "yml"
            },
            settings = {
                ansible = {
                    ansible = {
                        path = "ansible",
                        useFullyQualifiedCollectionNames = true
                    },
                    ansibleLint = {
                        enabled = true,
                        path = "ansible-lint"
                    },
                    executionEnvironment = {
                        enabled = false
                    },
                    python = {
                        interpreterPath = "python"
                    },
                    completion = {
                        provideRedirectModules = true,
                        provideModuleOptionAliases = true
                    }
                },
            },
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                require("lsp-inlayhints").setup({
                    inlay_hints = {
                        parameter_hints = { prefix = "in: " }, -- "<- "
                        type_hints = { prefix = "out: " }      -- "=> "
                    }
                })
                require("lsp-inlayhints").on_attach(client, bufnr)
                require("illuminate").on_attach(client)
            end,
        })
    end

}
