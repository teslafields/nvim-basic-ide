local M = {
  "ahmedkhalf/project.nvim",
  commit = "685bc8e3890d2feb07ccf919522c97f7d33b94e4",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      event = "Bufenter",
      cmd = { "Telescope" },
    },
  },
}

function M.config()
  local project = require "project_nvim"
  project.setup {

    detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
    -- detection_methods = { "pattern" },

    -- patterns used to detect root dir, when **"pattern"** is in detection_methods
    patterns = { ".git", "package.json", "configure.ac" },

    -- Manual mode doesn't automatically change your root directory, so you have
    -- the option to manually do so using `:ProjectRoot` command.
    -- manual_mode = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true
    },
    show_hidden = true,
  }

  local telescope = require "telescope"
  telescope.load_extension "projects"
end

return M
