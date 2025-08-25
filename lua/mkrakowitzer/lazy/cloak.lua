return {
    "laytan/cloak.nvim",
    dependencies = { "folke/which-key.nvim" },

    config = function()
        require("cloak").setup({
            enabled = true,
            cloak_character = "*",
            highlight_group = "Comment",
            patterns = {
                {
                    file_pattern = { ".env*", "wrangler.toml", ".dev.vars" },
                    cloak_pattern = "=.+",
                },
            },
        })

        local wk = require("which-key")

        wk.add({
            { "<leader>c",  group = "+cloak",        mode = "n" },

            -- Mask / show / toggle
            { "<leader>cm", "<cmd>CloakEnable<CR>",  desc = "Mask secrets (enable)",  mode = "n" },
            { "<leader>cs", "<cmd>CloakDisable<CR>", desc = "Show secrets (disable)", mode = "n" },
            { "<leader>ct", "<cmd>CloakToggle<CR>",  desc = "Toggle cloak",           mode = "n" },

            -- Quick peek: briefly reveal, then re-mask after 1.5s
            {
                "<leader>cp",
                function()
                    vim.cmd("CloakDisable")
                    vim.defer_fn(function() vim.cmd("CloakEnable") end, 1500)
                end,
                desc = "Peek secrets (1.5s)",
                mode = "n"
            },
        })
    end,
}
