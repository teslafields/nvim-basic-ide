local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  event = { "BufReadPre" },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
}

function M.config()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      local opts = { buffer = event.buf, noremap = true, silent = true }
      local keymap = vim.keymap.set
      keymap("n", "gD", vim.lsp.buf.declaration, opts)
      keymap("n", "gd", vim.lsp.buf.definition, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "gI", vim.lsp.buf.implementation, opts)
      keymap("n", "gr", vim.lsp.buf.references, opts)
      keymap("n", "gl", vim.diagnostic.open_float, opts)
      keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
      -- keymap("n", "<leader>lj", function() vim.diagnostic.goto_next() end, opts)
      -- keymap("n", "<leader>lk", function() vim.diagnostic.goto_prev() end, opts)
      keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
      keymap("n", "<leader>lq", vim.diagnostic.setloclist, opts)
      keymap("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
      -- require("illuminate").on_attach(client)
    end
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  local on_init = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end

  local cfg = {};

  for _, server in pairs(require("lsp").servers) do
    cfg = {
      capabilities = capabilities,
      autostart = true,
      on_init = on_init
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
    if require_ok then
      cfg = vim.tbl_deep_extend("force", conf_opts, cfg)
    end

    vim.lsp.config(server, cfg)
    vim.lsp.enable(server)
  end

  local signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  }

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = signs,
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

  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --   border = "rounded",
  -- })
  --
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  --   border = "rounded",
  -- })

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
