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
                "gopls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
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
                --                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                --                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                --                [<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<Enter>'] = cmp.mapping.confirm({ select = true }),
                --                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
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

        require("lspconfig").gopls.setup({
            on_attach = function(client, bufnr)
                --mappings(client, bufnr)
                require("lsp-inlayhints").setup({
                    inlay_hints = {
                        parameter_hints = { prefix = "in: " }, -- "<- "
                        type_hints = { prefix = "out: " }      -- "=> "
                    }
                })
                require("lsp-inlayhints").on_attach(client, bufnr)
                require("illuminate").on_attach(client)

                -- DISABLED: FixGoImports
                --
                -- Instead I use https://github.com/incu6us/goimports-reviser
                -- Via https://github.com/stevearc/conform.nvim
                --
                --vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                --    group = vim.api.nvim_create_augroup("FixGoImports",
                --        { clear = true }),
                --    pattern = "*.go",
                --    callback = function()
                --        -- ensure imports are sorted and grouped correctly
                --        local params = vim.lsp.util.make_range_params()
                --        params.context = { only = { "source.organizeImports" } }
                --        local result =
                --        vim.lsp.buf_request_sync(0,
                --            "textDocument/codeAction",
                --            params)
                --        for _, res in pairs(result or {}) do
                --            for _, r in pairs(res.result or {}) do
                --                if r.edit then
                --                    vim.lsp.util.apply_workspace_edit(
                --                        r.edit, "UTF-8")
                --                else
                --                    vim.lsp.buf.execute_command(r.command)
                --                end
                --            end
                --        end
                --    end
                --})
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
    end
}
