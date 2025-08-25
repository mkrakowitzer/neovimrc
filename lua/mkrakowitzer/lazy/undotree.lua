return {
    "mbbill/undotree",
    config = function()
        local wk = require("which-key")

        wk.add({
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree", mode = "n" },
        })
    end
}
