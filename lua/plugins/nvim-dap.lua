return  {
  { "mfussenegger/nvim-dap" },
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
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
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
