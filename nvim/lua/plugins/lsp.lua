require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'lua_ls' },
}

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false },
    },
  },
})
require('mini.snippets').setup()
-- require("mini.snippets").loaders.from_vscode().lazy_load()
require('mini.pairs').setup()
require('mini.ai').setup()

require('blink.cmp').setup {
  keymap = {
    preset = 'default', -- gives you sane defaults
  },

  completion = {
    documentation = {
      auto_show = true,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'buffer', 'snippets' },
  },
  -- snippets = {
  --   expand = function(snippet) require('mini.snippets').expand(snippet.body) end,
  -- },
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end
    local buf = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local builtin = require 'telescope.builtin'

    -- Navigation
    map('gd', vim.lsp.buf.definition, 'Go to Definition')
    map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- Actions
    map('<leader>rn', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    map('<leader>f', vim.lsp.buf.format, 'Format')

    -- Telescope LSP pickers
    vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })
    vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })
    vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })

    -- Inlay hints (LSP suggestions shown inline)
    if client and client:supports_method 'textDocument/inlayHint' then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }) end, 'Toggle Inlay Hints')
    end

    -- CodeLens (show actionable info inline, e.g. "3 references")
    if client and client:supports_method 'textDocument/codeLens' then
      map('<leader>cl', vim.lsp.codelens.run, 'Run CodeLens')

      -- Re-refresh codelens whenever the buffer is written or enters insert→normal
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
        buffer = buf,
        callback = vim.lsp.codelens.run,
      })
    end

    -- Document highlight: highlight other uses of the symbol under cursor
    if client and client:supports_method 'textDocument/documentHighlight' then
      local hl_group = vim.api.nvim_create_augroup('lsp-document-highlight-' .. buf, { clear = true })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = buf,
        group = hl_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = buf,
        group = hl_group,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.lsp.codelens.run()
