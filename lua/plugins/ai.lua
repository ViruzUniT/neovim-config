return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>tc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>tf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>tr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>tC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>tm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>tb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>ts", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>ts",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			},
			-- Diff management
			{ "<leader>ta", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>tn", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
	{
		"olimorris/codecompanion.nvim",
		lazy = false,
		config = function()
			require("codecompanion").setup({
				display = {
					chat = {
						window = {
							layout = "float",
						},
					},
				},

				interactions = {
					chat = {
						adapter = "codex", -- Or "codex", "gemini_cli", "opencode" and more
						model = "gpt-6-luna",
					},
					cli = {
						agent = "codex",
						agents = {
							claude_code = {
								cmd = "codex",
								args = {},

								description = "Cody",
								provider = "terminal",
							},
							codex = {
								cmd = "codex",
								args = {},
								description = "OpenAI Codex CLI",
							},
						},
					},
				},

				adapters = {
					acp = {
						codex = function()
							return require("codecompanion.adapters").extend("codex", {
								defaults = {
									auth_method = "chat-gpt", -- Can be "api-key" or "chat-gpt"
								},
							})
						end,
					},
				},
			})
		end,
	},
}
