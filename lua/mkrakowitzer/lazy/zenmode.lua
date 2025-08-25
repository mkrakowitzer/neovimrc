return {
    "folke/zen-mode.nvim",
    config = function()
        local wk = require("which-key")

        wk.add({
            { "<leader>z", group = "+zen", mode = "n" },

            {
                "<leader>zz",
                function()
                    require("zen-mode").setup({
                        window = { width = 90, options = {} },
                    })
                    require("zen-mode").toggle()
                    vim.wo.wrap = false
                    vim.wo.number = true
                    vim.wo.rnu = true
                    ColorMyPencils()
                end,
                desc = "Zen Mode: Normal",
                mode = "n"
            },

            {
                "<leader>zZ",
                function()
                    require("zen-mode").setup({
                        window = { width = 80, options = {} },
                    })
                    require("zen-mode").toggle()
                    vim.wo.wrap = false
                    vim.wo.number = false
                    vim.wo.rnu = false
                    vim.opt.colorcolumn = "0"
                    ColorMyPencils()
                end,
                desc = "Zen Mode: Distraction-free",
                mode = "n"
            },
        })
    end
}
