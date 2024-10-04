return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
