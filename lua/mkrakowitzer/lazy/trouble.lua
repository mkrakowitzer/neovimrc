return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({ icons = false })

            local wk = require("which-key")
            wk.register({
                ["<leader>t"] = {
                    name = "+trouble",
                    t = { function() require("trouble").toggle() end, "Toggle Trouble" },
                },
                ["[t"] = { function() require("trouble").previous({ skip_groups = true, jump = true }) end, "Previous Trouble" },
                ["]t"] = { function() require("trouble").next({ skip_groups = true, jump = true }) end, "Next Trouble" },
            })
        end
    },
}
