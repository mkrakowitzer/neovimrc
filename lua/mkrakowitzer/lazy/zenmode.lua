return {
    "folke/zen-mode.nvim",
    config = function()
        local wk = require("which-key")

        wk.register({
            ["<leader>z"] = {
                z = { function()
                    require("zen-mode").setup {
                        window = {
                            width = 90,
                            options = {}
                        },
                    }
                    require("zen-mode").toggle()
                    vim.wo.wrap = false
                    vim.wo.number = true
                    vim.wo.rnu = true
                    ColorMyPencils()
                end, "Zen Mode: Normal" },

                Z = { function()
                    require("zen-mode").setup {
                        window = {
                            width = 80,
                            options = {}
                        },
                    }
                    require("zen-mode").toggle()
                    vim.wo.wrap = false
                    vim.wo.number = false
                    vim.wo.rnu = false
                    vim.opt.colorcolumn = "0"
                    ColorMyPencils()
                end, "Zen Mode: Distraction-free" },
            }
        }, { mode = "n" })
    end
}
