return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({ icons = false })

            local wk = require("which-key")

            wk.add({
                -- Group under <leader>t
                { "<leader>t",  group = "+trouble",                                                   mode = "n" },
                { "<leader>tt", function() trouble.toggle() end,                                      desc = "Toggle Trouble",   mode = "n" },

                -- Navigation
                { "[t",         function() trouble.previous({ skip_groups = true, jump = true }) end, desc = "Previous Trouble", mode = "n" },
                { "]t",         function() trouble.next({ skip_groups = true, jump = true }) end,     desc = "Next Trouble",     mode = "n" },
            })
        end
    },
}
