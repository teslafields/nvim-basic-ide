local M = {
  "neovim/nvim-lspconfig",
  commit = "649137cbc53a044bffde36294ce3160cb18f32c7",
  lazy = false,
  event = { "BufReadPre" },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef",
    },
  },
}

function M.config()
  local cmp_nvim_lsp = require "cmp_nvim_lsp"

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

  local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
    keymap(bufnr, "n", "<leader>lst", "<cmd>LspStart<cr>", opts)
    keymap(bufnr, "n", "<leader>lsp", "<cmd>LspStop<cr>", opts)
    keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", opts)
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  end

  local lspconfig = require "lspconfig"
  local on_init = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end
  local on_attach = function(client, bufnr)
    -- client.server_capabilities.semanticTokensProvider = nil
    lsp_keymaps(bufnr)
    require("illuminate").on_attach(client)
  end

  local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
  end

  local blacklist = require("utils").blacklist
  for _, server in pairs(require("utils").servers) do
    local autostart = true
    -- if has_value(blacklist, server) then
    --   autostart = false
    -- end
    Opts = {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
      autostart = autostart,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "settings." .. server)
    if require_ok then
      Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
    end

    lspconfig[server].setup(Opts)
  end

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- { "DEBUG", "INFO", "WARN", "ERROR", "OFF",
  --   [0] = "TRACE",
  --   DEBUG = 1,
  --   ERROR = 4,
  --   INFO = 2,
  --   OFF = 5,
  --   TRACE = 0,
  --   WARN = 3
  -- }
  -- vim.lsp.set_log_level(4)
  -- vim.lsp.set_log_level("off")
end

return M
