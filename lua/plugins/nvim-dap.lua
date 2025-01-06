return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local mason_registry = require("mason-registry")
      local java_debug_pkg = mason_registry.get_package("java-debug-adapter")
      local java_debug_path = java_debug_pkg:get_install_path()
      print(java_debug_path)
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(_, _)
      local path = 'debugpy'
      require("dap-python").setup(path)
      vim.keymap.set("n", "<leader>dpr", function()
        require('dap-python').test_method()
      end, { desc = "dap test method" })
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      handlers = {},
      ensure_installed = { "codelldb", "clangd", "clang-format" }
    }
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
    end
  },
}
