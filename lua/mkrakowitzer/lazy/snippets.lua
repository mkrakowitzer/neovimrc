return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "folke/which-key.nvim",
        },
        config = function()
            local ls = require("luasnip")
            -- Extend filetypes for JavaScript and Go
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("go", { "go" })

            local wk = require("which-key")
            wk.add({
                -- Snippet expansion and navigation
                { "<C-s>e", function() ls.expand() end, desc = "Expand snippet",        mode = { "i", "s" } },
                { "<C-s>;", function() ls.jump(1) end,  desc = "Next snippet node",     mode = { "i", "s" } },
                { "<C-s>,", function() ls.jump(-1) end, desc = "Previous snippet node", mode = { "i", "s" } },

                -- Snippet choice
                {
                    "<C-E>",
                    function()
                        if ls.choice_active() then
                            ls.change_choice(1)
                        end
                    end,
                    desc = "Change snippet choice",
                    mode = { "i", "s" }
                },
            })
        end,
    },
}
