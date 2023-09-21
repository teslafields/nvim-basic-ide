local M = {
  "ellisonleao/gruvbox.nvim",
  commit = "7a5c7ace3ac169b2898a4c7d8abec42cf9e18003",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = "gruvbox"
function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
