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

        wk.register({
            ["<leader>"] = {
                f = { vim.lsp.buf.format, "Format buffer" },
                s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and replace" },
                x = { "<cmd>!chmod +x %<CR>", "Make file executable", silent = true },
                ee = { "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", "Go error check" },
                k = { "<cmd>lnext<CR>zz", "Next location list item" },
                j = { "<cmd>lprev<CR>zz", "Previous location list item" },
                y = { [["+y]], "Yank to clipboard" },
                Y = { [["+Y]], "Yank line to clipboard" },
                d = { [["_d]], "Delete without yanking" },
            },
            ["J"] = { "mzJ`z", "Join lines and restore cursor position" },
            ["<C-d>"] = { "<C-d>zz", "Scroll down and center" },
            ["<C-u>"] = { "<C-u>zz", "Scroll up and center" },
            ["n"] = { "nzzzv", "Find next and center" },
            ["N"] = { "Nzzzv", "Find previous and center" },
            ["Q"] = { "<nop>", "Disable Q" },
            ["<C-f>"] = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Tmux sessionizer" },
            ["<C-k>"] = { "<cmd>cnext<CR>zz", "Next quickfix item" },
            ["<C-j>"] = { "<cmd>cprev<CR>zz", "Previous quickfix item" },
            -- Pane navigation
            ["<C-w>-"] = { "<C-w>s", "Split window horizontally" },
            ["<C-w>|"] = { "<C-w>v", "Split window vertically" },
            -- Works around a weird issue where A is mapped to the matchit plugin
            ["a"] = { "a", "which_key_ignore" },
        }, { mode = "n" })

        wk.register({
            ["J"] = { ":m '>+1<CR>gv=gv", "Move line/selection down" },
            ["K"] = { ":m '<-2<CR>gv=gv", "Move line/selection up" },
        }, { mode = "v" })

        wk.register({
            ["<leader>y"] = { [["+y]], "Yank to clipboard" },
            ["<leader>d"] = { [["_d]], "Delete without yanking" },
        }, { mode = { "n", "v" } })
    end
}
