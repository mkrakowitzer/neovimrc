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
            wk.register({
                ["<leader>t"] = {
                    name = "+test", -- Test group
                    c = { function() neotest.run.run() end, "Run closest test" },
                    f = { function() neotest.run.run(vim.fn.expand("%")) end, "Run tests in current file" },
                    a = { function() neotest.run.run({ suite = true }) end, "Run all tests" },
                    l = { function() neotest.run.run_last() end, "Run last test" },
                    s = { function() neotest.summary.toggle() end, "Toggle test summary" },
                    o = { function() neotest.output.open() end, "Open test output" },
                },
            })
        end,
    },
}
