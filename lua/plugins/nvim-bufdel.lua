local M = {
  'ojroques/nvim-bufdel',
  event = "VeryLazy",
}

function M.config()
  local bufdel = require "bufdel"
  bufdel.setup {
    next = 'tabs',
    quit = true,  -- quit Neovim when last buffer is closed
  }
end

return M
