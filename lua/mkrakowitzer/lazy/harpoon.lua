return {
    "theprimeagen/harpoon",

    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim"
    },
    branch = "harpoon2",

    config = function()
        local harpoon = require('harpoon')
        local wk = require('which-key')
        harpoon:setup({})

        wk.add({
            { "<leader>a", function() harpoon:list():add() end,                         desc = "Harpoon: Mark file",   mode = "n" },
            { "<C-e>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: Toggle menu", mode = "n" },
            { "<C-h>",     function() harpoon:list():prev() end,                        desc = "Harpoon: Previous",    mode = "n" },
            { "<C-l>",     function() harpoon:list():next() end,                        desc = "Harpoon: Next",        mode = "n" },
            { "<C-1>",     function() harpoon:list():select(1) end,                     desc = "Harpoon: Select 1",    mode = "n" },
            { "<C-2>",     function() harpoon:list():select(2) end,                     desc = "Harpoon: Select 2",    mode = "n" },
            { "<C-3>",     function() harpoon:list():select(3) end,                     desc = "Harpoon: Select 3",    mode = "n" },
            { "<C-4>",     function() harpoon:list():select(4) end,                     desc = "Harpoon: Select 4",    mode = "n" },
        })

        wk.add({
            { "<leader>h",  group = "Harpoon" },
            { "<leader>ha", function() harpoon:list():add() end, desc = "Mark file", mode = "n" },
        })
    end
}
