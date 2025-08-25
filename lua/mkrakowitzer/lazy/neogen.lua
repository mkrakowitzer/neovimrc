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
        wk.add({
            { "<leader>n",  group = "+neogen",                                            mode = "n" },
            { "<leader>nf", function() require("neogen").generate({ type = "func" }) end, desc = "Generate function documentation", mode = "n" },
            { "<leader>nt", function() require("neogen").generate({ type = "type" }) end, desc = "Generate type documentation",     mode = "n" },
        })
    end,
}
