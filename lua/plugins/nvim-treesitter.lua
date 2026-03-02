local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,

      -- Enable traditional Vim regex highlighting for C and Rust
      additional_vim_regex_highlighting = { "c", "rust" },
    },
  },
}

return M
