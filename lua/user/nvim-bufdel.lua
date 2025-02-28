local M = {
  'ojroques/nvim-bufdel',
  commit = "523d58e94e7212fff3e05c247b962dc8f93bcfde",
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
