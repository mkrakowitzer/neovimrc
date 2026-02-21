return {
    -- FORMATTING
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- https://pkg.go.dev/golang.org/x/tools/cmd/goimports (auto imports)
                -- https://github.com/incu6us/goimports-reviser
                go = { "goimports", "goimports-reviser" },
                -- https://github.com/jqlang/jq
                jq = { "jq" },
                -- https://github.com/rhysd/fixjson
                json = { "fixjson" },
                -- https://github.com/executablebooks/mdformat
                -- markdown = { "mdformat" },
                -- https://github.com/koalaman/shellcheck
                sh = { "shellcheck" },
                -- https://www.terraform.io/docs/cli/commands/fmt.html
                -- https://opentofu.org/docs/cli/commands/fmt/  NOTE: This is an alternative `tofu_fmt`
                terraform = { "terraform_fmt" },
                -- http://xmlsoft.org/xmllint.html
                yaml = { "yq" },
            },
            format_after_save = function(bufnr)
                -- disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { async = true, timeout_ms = 5000, lsp_fallback = true }
            end
        })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })

        local wk = require("which-key")

        wk.add({
            { "<leader>f", group = "+format", mode = "n" },
            {
                "<leader>ff",
                function() conform.format({ async = true, lsp_fallback = true }) end,
                desc = "Format buffer",
                mode = "n",
            },
            { "<leader>fd", "<Cmd>FormatDisable<CR>", desc = "Disable autoformat-on-save", mode = "n" },
            { "<leader>fe", "<Cmd>FormatEnable<CR>",  desc = "Re-enable autoformat-on-save", mode = "n" },
        })
    end
}
