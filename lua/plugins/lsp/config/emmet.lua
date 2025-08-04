local M = {}

M.setup = function(capabilities)
  local cfg = {
    capabilities = capabilities,
    filetypes = {
      "css",
      "eruby",
      "html",
      "javascript",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "pug",
      "typescriptreact",
    },
  }
  return cfg
end

return M
