return {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
        "folke/which-key.nvim",
    },
    config = function()
        require("neogen").setup({ snippet_engine = "luasnip" })

        local wk = require("which-key")
        wk.register({
            ["<leader>n"] = {
                name = "+neogen",
                f = { function() require("neogen").generate({ type = "func" }) end, "Generate function documentation" },
                t = { function() require("neogen").generate({ type = "type" }) end, "Generate type documentation" },
            },
        })
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
}
