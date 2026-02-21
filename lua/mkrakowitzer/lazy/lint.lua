return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        local wanted_linters_by_ft = {
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
            markdown = { "markdownlint", "vale", "codespell" },
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
            zsh = { "shellcheck", "zsh" },
            -- https://github.com/ansible/ansible-lint
            ansible = { "ansible_lint" },
        }

        local function linter_available(name)
            local linter = lint.linters[name]
            if not linter then
                return false
            end
            local cmd = linter.cmd
            if type(cmd) == "function" then
                local ok, resolved = pcall(cmd)
                if ok then
                    cmd = resolved
                else
                    return false
                end
            end
            if type(cmd) == "table" then
                cmd = cmd[1]
            end
            if type(cmd) ~= "string" or cmd == "" then
                return false
            end
            return vim.fn.executable(cmd) == 1
        end

        lint.linters_by_ft = {}
        for ft, linters in pairs(wanted_linters_by_ft) do
            local available = {}
            for _, linter in ipairs(linters) do
                if linter_available(linter) then
                    table.insert(available, linter)
                end
            end
            lint.linters_by_ft[ft] = available
        end

        vim.api.nvim_create_autocmd({
            "BufReadPost", "BufWritePost", "InsertLeave"
        }, {
            group = vim.api.nvim_create_augroup("Linting", { clear = true }),
            callback = function(ev)
                local filetype = vim.bo[ev.buf].filetype
                local is_github_yaml = filetype == "yaml" and (
                    string.find(ev.file, ".github/workflows/", 1, true) or
                    string.find(ev.file, ".github/actions/", 1, true)
                )
                if is_github_yaml then
                    if linter_available("actionlint") then
                        lint.try_lint("actionlint")
                    elseif linter_available("yamllint") then
                        lint.try_lint("yamllint")
                    end
                elseif filetype == "yaml" then
                    if linter_available("yamllint") then
                        lint.try_lint("yamllint")
                    end
                else
                    lint.try_lint()
                end
            end
        })
    end
}
