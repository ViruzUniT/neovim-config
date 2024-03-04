return {
  "jose-elias-alvarez/null-ls.nvim",
  lazy = false,
  config = function()
    local null_ls = require "null-ls"
    null_ls.setup {
      debug = true,
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            gruop = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            gruop = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    }
  end
}
