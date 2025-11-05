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
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local opts = { buffer = ev.buf, noremap = true, silent = true }
      local keymap = vim.keymap
      keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      keymap.set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
      keymap.set("n", "<leader>lst", "<cmd>LspStart<cr>", opts)
      keymap.set("n", "<leader>lsp", "<cmd>LspStop<cr>", opts)
      keymap.set("n", "<leader>lI", "<cmd>Mason<cr>", opts)
      keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      keymap.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
      keymap.set("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
      keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
      keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
      require("illuminate").on_attach(client)

      client.server_capabilities.semanticTokensProvider = nil
    end
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  local on_init = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end

  for _, server in pairs(require("lsp").servers) do
    cfg = {
      capabilities = capabilities,
      autostart = true,
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
