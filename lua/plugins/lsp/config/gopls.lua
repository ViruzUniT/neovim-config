local M = {}

M.setup = function(capabilities)
  local util = require("lspconfig.util")
  local cfg = {
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomode", "gowork", "gompl" },
    rootdir = util.root_pattern("go.work", "go.mod"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  }
  return cfg
end

return M
