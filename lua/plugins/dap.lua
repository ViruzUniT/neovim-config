return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			dap.adapters.python = {
				type = "executable",
				command = "python", -- or the path to your python executable
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						-- This is a great way to handle virtual environments
						local venv_path = os.getenv("VIRTUAL_ENV")
						if venv_path then
							return venv_path .. "/bin/python"
						end
						local cwd = vim.fn.getcwd()
						if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						end
						return "python" -- Fallback to system python
					end,
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapiu = require("dapui")
			dapiu.setup()
			dap.listeners.after.event_initialized["dapiu_config"] = function()
				dapiu.open()
			end
			dap.listeners.before.event_terminated["dapiu_config"] = function()
				dapiu.close()
			end
			dap.listeners.before.event_exited["dapiu_config"] = function()
				dapiu.close()
			end
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				delve = {
					path = "dlv.cmd",
					initialize_timeout_sec = 20,
					port = "${port}",
					args = {},
					build_flags = {},
					detached = vim.fn.has("win32") == 0,
					cwd = nil,
				},
				tests = {
					verbose = false,
				},
			})
		end,
	},
}
