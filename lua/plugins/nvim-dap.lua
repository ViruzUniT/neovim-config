return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local mason_registry = require("mason-registry")
      local java_debug_pkg = mason_registry.get_package("java-debug-adapter")
      local java_debug_path = java_debug_pkg:get_install_path()
      print(java_debug_path)

      local dap = require("dap")

      dap.adapters.java = function(callback, config)
        local mason_registry = require("mason-registry")
        local java_debug_pkg = mason_registry.get_package("java-debug-adapter")
        local java_debug_path = java_debug_pkg:get_install_path()
        local executable = java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"

        callback({
          type = "server",
          host = "127.0.0.1",
          port = 57046,
          executable = {
            command = "java",
            args = {
              "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=127.0.0.1:" .. 57046,
              "-cp",
              executable,
              "com.microsoft.java.debug.core.JavaDebugServer"
            },
          },
        })
      end

      dap.configurations.java = {
        {
          type = "java",
          request = "launch",
          name = "Launch Java Program",
          mainClass = function()
            return vim.fn.input("Enter main class: ")
          end,
          args = function()
            return vim.fn.input("Enter program arguments: ")
          end,
        },
      }
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
