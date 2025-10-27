local M = {
  "ellisonleao/gruvbox.nvim",
  name = 'gruvbox',
  -- "sainnhe/gruvbox-material",
  -- name = 'gruvbox-material',
  -- "catppuccin/nvim",
  -- name = "catppuccin",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  -- require(M.name).setup({
  --   flavour = "macchiato", -- latte, frappe, macchiato, mocha
  -- })
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
