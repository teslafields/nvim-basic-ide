local M = {
  "nvim-telescope/telescope.nvim",
  commit = "40c31fdde93bcd85aeb3447bb3e2a3208395a868",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    {
      "ahmedkhalf/project.nvim",
    },
    {
      "nvim-lua/plenary.nvim",
    }
  },
}

local actions = require "telescope.actions"

M.opts = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--case-sensitive",
      "--hidden",
      "--no-ignore",
      "--glob=!tags", -- Exclude tags file at least
    },
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "truncate" },
    file_ignore_patterns = { ".git", "node_modules", ".cache" },
    preview = false,
    mappings = {
      i = {
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {
        'fd',
        '--type',
        'f',
        '--color=never',
        '--follow',
        '--unrestricted', -- -H + -I
      },
    },
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  },
}

return M
