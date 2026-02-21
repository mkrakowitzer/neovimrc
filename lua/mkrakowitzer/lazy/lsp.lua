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
        "folke/which-key.nvim",
        "RRethy/vim-illuminate",
    },

    config = function()
        -- ===== cmp capabilities =====
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -- ===== which-key =====
        local wk = require("which-key")
        wk.add({
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

        -- ===== UI helpers =====
        require("fidget").setup({})

        -- ===== Built-in inlay hints helper =====
        local function enable_inlay_hints(bufnr)
            local ih = vim.lsp.inlay_hint
            if not ih then return end
            if type(ih) == "function" then
                pcall(ih, bufnr, true)                       -- Neovim 0.9
            elseif type(ih) == "table" and ih.enable then
                local ok = pcall(ih.enable, ih, bufnr, true) -- Neovim 0.10+
                if not ok then pcall(ih.enable, true, { bufnr = bufnr }) end
            end
        end

        local function base_on_attach(client, bufnr)
            if client and client.server_capabilities and client.server_capabilities.inlayHintProvider then
                enable_inlay_hints(bufnr)
            end
            -- Illuminate (guarded so it will not error if plugin is missing)
            pcall(function() require("illuminate").on_attach(client) end)
        end

        -- ===== Mason + LSP =====
        local servers = {
            "lua_ls",
            "rust_analyzer",
            "gopls",
            "ansiblels",
        }
        local server_overrides = {
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "Lua 5.1" },
                        diagnostics = {
                            globals = { "vim", "it", "describe", "before_each", "after_each" },
                        },
                    },
                },
            },
            gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        experimentalPostfixCompletions = true,
                        gofumpt = true,
                        usePlaceholders = true,
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            },
            ansiblels = {
                filetypes = { "yaml" },
                settings = {
                    ansible = {
                        ansible = {
                            path = "ansible",
                            useFullyQualifiedCollectionNames = true,
                        },
                        ansibleLint = {
                            enabled = true,
                            path = "ansible-lint",
                        },
                        executionEnvironment = { enabled = false },
                        python = { interpreterPath = "python" },
                        completion = {
                            provideRedirectModules = true,
                            provideModuleOptionAliases = true,
                        },
                    },
                },
            },
        }

        -- In headless runs (e.g. checks/tests), skip mason registry operations.
        local has_ui = #vim.api.nvim_list_uis() > 0
        if has_ui then
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_enable = false,
            })
        end

        for _, server in ipairs(servers) do
            local opts = vim.tbl_deep_extend("force", {
                capabilities = capabilities,
                on_attach = base_on_attach,
            }, server_overrides[server] or {})
            vim.lsp.config(server, opts)
            vim.lsp.enable(server)
        end

        -- Enable any extra server configs that are present and not explicitly configured above.
        if has_ui then
            for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
                if not vim.tbl_contains(servers, server) then
                    vim.lsp.config(server, {
                        capabilities = capabilities,
                        on_attach = base_on_attach,
                    })
                    vim.lsp.enable(server)
                end
            end
        end

        -- ===== Diagnostics UI =====
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
        -- ===== nvim-cmp =====
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args) require("luasnip").lsp_expand(args.body) end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Enter>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
        })
    end,
}
