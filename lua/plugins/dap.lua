local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "jbyuki/one-small-step-for-vimkind",
  },
  lazy = false,
}

function M.config()
  local dap = require "dap"
  dap.configurations.lua = {
    {
      type = 'nlua',
      request = 'attach',
      name = "Attach to running Neovim instance",
    }
  }

  dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

  vim.keymap.set('n', '<leader>kb', dap.toggle_breakpoint, { noremap = true })
  vim.keymap.set('n', '<leader>kc', dap.continue, { noremap = true })
  vim.keymap.set('n', '<leader>ko', dap.step_over, { noremap = true })
  vim.keymap.set('n', '<leader>ki', dap.step_into, { noremap = true })

  vim.keymap.set('n', '<leader>dl', function()
    require "osv".launch({ port = 8086 })
  end, { noremap = true })

  vim.keymap.set('n', '<leader>dw', function()
    local widgets = dap.ui.widgets
    widgets.hover()
  end)

  vim.keymap.set('n', '<leader>df', function()
    local widgets = dap.ui.widgets
    widgets.centered_float(widgets.frames)
  end)
end

return M
