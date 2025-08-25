return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/nvim-nio",
            "folke/which-key.nvim",
        },
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-vitest"),
                    require("neotest-plenary").setup({
                        min_init = "./scripts/tests/minimal.vim",
                    }),
                }
            })

            local wk = require("which-key")
            wk.add({
                { "<leader>t",  group = "+test",                                    mode = "n" },
                { "<leader>tc", function() neotest.run.run() end,                   desc = "Run closest test",          mode = "n" },
                { "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Run tests in current file", mode = "n" },
                { "<leader>ta", function() neotest.run.run({ suite = true }) end,   desc = "Run all tests",             mode = "n" },
                { "<leader>tl", function() neotest.run.run_last() end,              desc = "Run last test",             mode = "n" },
                { "<leader>ts", function() neotest.summary.toggle() end,            desc = "Toggle test summary",       mode = "n" },
                { "<leader>to", function() neotest.output.open() end,               desc = "Open test output",          mode = "n" },
            })
        end,
    },
}
