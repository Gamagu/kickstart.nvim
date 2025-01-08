-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		"hedyhli/outline.nvim",
		config = function()
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
			vim.keymap.set("n", "<leader>co", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
			})
		end,
	},
	{
		"nvim-lua/lsp-status.nvim",
	},
}
