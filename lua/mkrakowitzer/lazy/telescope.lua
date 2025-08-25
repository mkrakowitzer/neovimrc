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

        wk.add({
            -- Group label under <leader>p
            { "<leader>p",  group = "+telescope", mode = "n" },

            -- Sub-commands
            { "<leader>pv", "<cmd>Ex<CR>",        desc = "Open file explorer", mode = "n" },
            { "<leader>pf", builtin.find_files,   desc = "Find Files",         mode = "n" },

            {
                "<leader>pws",
                function()
                    local word = vim.fn.expand("<cword>")
                    builtin.grep_string({ search = word })
                end,
                desc = "Grep Current Word (small)",
                mode = "n"
            },

            {
                "<leader>pWs",
                function()
                    local word = vim.fn.expand("<cWORD>")
                    builtin.grep_string({ search = word })
                end,
                desc = "Grep Current WORD (BIG)",
                mode = "n"
            },

            {
                "<leader>ps",
                function()
                    builtin.grep_string({ search = vim.fn.input("Grep > ") })
                end,
                desc = "Search String",
                mode = "n"
            },

            { "<leader>ph", builtin.help_tags, desc = "Help Tags", mode = "n" },

            -- Standalone mapping
            { "<C-p>",      builtin.git_files, desc = "Git Files", mode = "n" },
        })
    end,
}
