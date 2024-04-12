return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            -- https://github.com/codespell-project/codespell
            -- https://golangci-lint.run/
            go = { "codespell", "golangcilint" },
            -- https://htmlhint.com/
            -- https://www.html-tidy.org/
            html = { "htmlhint", "tidy" },
            -- https://github.com/mantoni/eslint_d.js
            json = { "jsonlint" },
            -- https://github.com/mrtazz/checkmake
            make = { "checkmake" },
            -- https://github.com/DavidAnson/markdownlint
            markdown = { "markdownlint", "vale" },
            -- https://www.shellcheck.net/
            sh = { "shellcheck" },
            -- https://github.com/aquasecurity/trivy (originally https://github.com/aquasecurity/tfsec)
            terraform = { "trivy" },
            -- DISABLED: needed custom logic (see callback function below)
            -- https://github.com/rhysd/actionlint
            -- https://github.com/adrienverge/yamllint https://yamllint.readthedocs.io/en/stable/rules.html
            -- yaml = { "actionlint", "yamllint" },
            -- https://www.shellcheck.net/
            -- https://www.zsh.org/
            zsh = { "shellcheck", "zsh" }
        }

        --        local markdownlint = require("lint").linters.markdownlint
        --        markdownlint.args = {
        --            "--disable",
        --            "MD013", "MD012",
        --            "--", -- Required
        --        }
        --
        --        -- Automatically lint on events. You can adjust the events as needed.
        --        -- Commonly used events include BufEnter, BufWritePost, and TextChanged.
        --        vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
        --            pattern = { "*.py" }, -- Adjust the pattern to match the file types you want to lint
        --            callback = function()
        --                lint.try_lint()
        --            end
        --      })
        vim.api.nvim_create_autocmd({
            "BufReadPost", "BufWritePost", "InsertLeave"
        }, {
            group = vim.api.nvim_create_augroup("Linting", { clear = true }),
            callback = function(ev)
                if (string.find(ev.file, ".github/workflows/") or string.find(ev.file, ".github/actions/")) and vim.bo.filetype == "yaml" then
                    lint.try_lint("actionlint")
                elseif vim.bo.filetype == "yaml" then
                    lint.try_lint("yamllint")
                else
                    lint.try_lint()
                end
            end
        })
    end
}
