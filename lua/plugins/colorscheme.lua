local M = { {
  "ellisonleao/gruvbox.nvim",
  name = 'gruvbox',
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
},
{
  "sainnhe/gruvbox-material",
  name = 'gruvbox-material',
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    pcall(vim.cmd.colorscheme, "gruvbox")
  end
},
{
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
},
{
  "EdenEast/nightfox.nvim",
  name = "nightfox",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}
}

return M
