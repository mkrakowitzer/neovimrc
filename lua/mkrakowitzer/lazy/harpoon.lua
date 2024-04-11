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

        wk.register({
            ["<leader>"] = {
                a = { function() harpoon:list():add() end, "Harpoon: Mark file" },
            },
            ["<C-e>"] = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Harpoon: Toggle menu" },
            ["<C-h>"] = { function() harpoon:list():prev() end, "Harpoon: Previous mark" },
            ["<C-l>"] = { function() harpoon:list():next() end, "Harpoon: Next mark" },
            ["<C-1>"] = { function() harpoon:list():select(1) end, "Harpoon: Select mark 1" },
            ["<C-2>"] = { function() harpoon:list():select(2) end, "Harpoon: Select mark 2" },
            ["<C-3>"] = { function() harpoon:list():select(3) end, "Harpoon: Select mark 3" },
            ["<C-4>"] = { function() harpoon:list():select(4) end, "Harpoon: Select mark 4" },
        }, { mode = "n" }) -- Normal mode mappings
    end
}
