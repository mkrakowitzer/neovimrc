return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/which-key.nvim",
    },
    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        local wk = require("which-key")

        wk.register({
            ["<leader>p"] = {
                name = "+telescope",
                v = { "<cmd>Ex<CR>", "Open file explorer" },
                f = { builtin.find_files, "Find Files" },
                ws = { function()
                    local word = vim.fn.expand("<cword>")
                    builtin.grep_string({ search = word })
                end, "Grep Current Word (Small)" },
                Ws = { function()
                    local word = vim.fn.expand("<cWORD>")
                    builtin.grep_string({ search = word })
                end, "Grep Current WORD (Big)" },
                s = { function()
                    builtin.grep_string({ search = vim.fn.input("Grep > ") })
                end, "Search String" },
                h = { builtin.help_tags, "Help Tags" },
            },
            ["<C-p>"] = { builtin.git_files, "Git Files" },
        })
    end,
}
