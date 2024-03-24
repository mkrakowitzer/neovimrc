
return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require('lint')

        -- Setup linters here. This is an example setup for Python using flake8.
        -- You can configure other linters and filetypes as needed.
        lint.linters_by_ft = {
            python = {'markdownlint'}, -- Ensure you have flake8 installed (`pip install flake8`)
            -- Add other filetypes and their respective linters here
        }

        -- Automatically lint on events. You can adjust the events as needed.
        -- Commonly used events include BufEnter, BufWritePost, and TextChanged.
        vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
            pattern = { "*.py" }, -- Adjust the pattern to match the file types you want to lint
            callback = function()
                lint.try_lint()
            end
        })
    end
}
