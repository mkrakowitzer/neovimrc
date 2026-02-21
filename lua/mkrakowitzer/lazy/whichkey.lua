return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        local wk = require("which-key")

        wk.setup {}

        wk.add({
            { "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Search and replace", mode = "n" },
            { "<leader>x", "<cmd>!chmod +x %<CR>", desc = "Make file executable", silent = true, mode = "n" },
            { "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", desc = "Go error check", mode = "n" },
            { "<leader>k", "<cmd>lnext<CR>zz", desc = "Next location list item", mode = "n" },
            { "<leader>j", "<cmd>lprev<CR>zz", desc = "Previous location list item", mode = "n" },
            { "<leader>Y", '"+Y', desc = "Yank line to clipboard", mode = "n" },

            { "J", "mzJ`z", desc = "Join lines and restore cursor position", mode = "n" },
            { "<C-d>", "<C-d>zz", desc = "Scroll down and center", mode = "n" },
            { "<C-u>", "<C-u>zz", desc = "Scroll up and center", mode = "n" },
            { "n", "nzzzv", desc = "Find next and center", mode = "n" },
            { "N", "Nzzzv", desc = "Find previous and center", mode = "n" },
            { "Q", "<nop>", desc = "Disable Q", mode = "n" },
            { "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", desc = "Tmux sessionizer", mode = "n" },
            { "<C-k>", "<cmd>cnext<CR>zz", desc = "Next quickfix item", mode = "n" },
            { "<C-j>", "<cmd>cprev<CR>zz", desc = "Previous quickfix item", mode = "n" },

            { "<C-w>-", "<C-w>s", desc = "Split window horizontally", mode = "n" },
            { "<C-w>|", "<C-w>v", desc = "Split window vertically", mode = "n" },

            { "J", ":m '>+1<CR>gv=gv", desc = "Move line/selection down", mode = "v" },
            { "K", ":m '<-2<CR>gv=gv", desc = "Move line/selection up", mode = "v" },

            { "<leader>y", '"+y', desc = "Yank to clipboard", mode = { "n", "v" } },
            { "<leader>d", '"_d', desc = "Delete without yanking", mode = { "n", "v" } },
        })

    end
}
