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
          {
            mode = "n",
            { "<leader>f", vim.lsp.buf.format, desc = "Format buffer" },
            { "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Search and replace" },
            { "<leader>x", "<cmd>!chmod +x %<CR>", desc = "Make file executable", silent = true },
            { "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", desc = "Go error check" },
            { "<leader>k", "<cmd>lnext<CR>zz", desc = "Next location list item" },
            { "<leader>j", "<cmd>lprev<CR>zz", desc = "Previous location list item" },
            { "<leader>y", '"+y', desc = "Yank to clipboard" },
            { "<leader>Y", '"+Y', desc = "Yank line to clipboard" },
            { "<leader>d", '"_d', desc = "Delete without yanking" },

            { "J", "mzJ`z", desc = "Join lines and restore cursor position" },
            { "<C-d>", "<C-d>zz", desc = "Scroll down and center" },
            { "<C-u>", "<C-u>zz", desc = "Scroll up and center" },
            { "n", "nzzzv", desc = "Find next and center" },
            { "N", "Nzzzv", desc = "Find previous and center" },
            { "Q", "<nop>", desc = "Disable Q" },
            { "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", desc = "Tmux sessionizer" },
            { "<C-k>", "<cmd>cnext<CR>zz", desc = "Next quickfix item" },
            { "<C-j>", "<cmd>cprev<CR>zz", desc = "Previous quickfix item" },

            -- Pane navigation
            { "<C-w>-", "<C-w>s", desc = "Split window horizontally" },
            { "<C-w>|", "<C-w>v", desc = "Split window vertically" },

            -- Works around matchit plugin issue
            { "a", "a", desc = "which_key_ignore" },
          },

          {
            mode = "v",
            { "J", ":m '>+1<CR>gv=gv", desc = "Move line/selection down" },
            { "K", ":m '<-2<CR>gv=gv", desc = "Move line/selection up" },
          },

          {
            mode = { "n", "v" },
            { "<leader>y", '"+y', desc = "Yank to clipboard" },
            { "<leader>d", '"_d', desc = "Delete without yanking" },
          },
        })

    end
}
