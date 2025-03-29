return {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
  opts = function ()
    return require "core.configs.null-ls"
  end,
}
