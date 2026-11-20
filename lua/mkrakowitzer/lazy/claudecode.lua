return {
    "coder/claudecode.nvim",
    opts = { auto_start = false },
    keys = {
        { "<leader>c",  nil,                             desc = "+claude" },
        { "<leader>co", "<cmd>ClaudeCodeStart<cr>",      desc = "Claude: Turn on" },
        { "<leader>cx", "<cmd>ClaudeCodeStop<cr>",       desc = "Claude: Turn off" },
        { "<leader>ci", "<cmd>ClaudeCodeStatus<cr>",     desc = "Claude: Status" },
        { "<leader>cc", "<cmd>ClaudeCode<cr>",           desc = "Claude: Toggle" },
        { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",      desc = "Claude: Focus" },
        { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",      desc = "Claude: Add buffer" },
        { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",       desc = "Claude: Send selection", mode = "v" },
        { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: Accept diff" },
        { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Claude: Reject diff" },
    },
}
