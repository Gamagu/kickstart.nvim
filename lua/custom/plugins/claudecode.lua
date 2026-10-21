return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = function()
    require("claudecode").setup({
      terminal = {
        split_side = "right",
        split_width_percentage = 0.30,
      },
    })

    vim.o.autoread = true

    -- Toggle Claude
    vim.keymap.set("n", "<leader>p.", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })

    -- Focus / Send selection
    vim.keymap.set("n", "<leader>pc", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
    vim.keymap.set("v", "<leader>pc", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection to Claude" })

    -- Select model
    vim.keymap.set("n", "<leader>pm", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })

    -- Send range/line to Claude context
    vim.keymap.set({ "n", "x" }, "gp", "<cmd>ClaudeCodeSend<cr>", { desc = "Send range to Claude" })
    vim.keymap.set("n", "gpp", "V<cmd>ClaudeCodeSend<cr>", { desc = "Send line to Claude" })

    -- Add current buffer to context
    vim.keymap.set("n", "<leader>pb", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer to Claude" })

    -- Diff management
    vim.keymap.set("n", "<leader>pa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept Claude diff" })
    vim.keymap.set("n", "<leader>pd", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny Claude diff" })

    -- Resume/Continue
    vim.keymap.set("n", "<leader>pr", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
    vim.keymap.set("n", "<leader>pC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })

    -- Tree file explorer integration
    vim.keymap.set("n", "<leader>ps", "<cmd>ClaudeCodeTreeAdd<cr>", { desc = "Add file from tree to Claude" })
  end,
}
