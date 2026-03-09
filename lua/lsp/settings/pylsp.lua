return {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        -- For formatting:
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
      },
    },
  },
}
