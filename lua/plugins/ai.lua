return {
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
