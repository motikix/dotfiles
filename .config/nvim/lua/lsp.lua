-- locals
local opts = require('config').opts

-- nvim-lspconfig

local lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<Cr>', opts)
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
  buf_set_keymap('n', '<Leader>lr', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
  buf_set_keymap('n', '<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
  buf_set_keymap('n', '<Leader>lA', '<Cmd>lua vim.lsp.buf.range_code_action()<Cr>', opts)

  -- document highlighting
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_create_augroup('lsp_document_highlight', {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = 'lsp_document_highlight',
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- format on save
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_create_augroup('LspFormatting', {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = 'LspFormatting',
    })
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = 'LspFormatting',
      buffer = bufnr,
      callback = vim.lsp.buf.formatting_sync,
    })
  end
end
local with_no_lspfmt = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  on_attach(client, bufnr)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lsp providers

lsp.ccls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    cache = {
      directory = '/tmp/ccls-cache',
    },
  },
})
lsp.gopls.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
})
lsp.rust_analyzer.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
})
lsp.zls.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
})
lsp.denols.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
  init_options = { enable = true, lint = true, unstable = true },
})
lsp.tsserver.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern('package.json'),
})
lsp.dartls.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
})
lsp.vuels.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
})
lsp.svelte.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
})
lsp.astro.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.pyright.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
})
lsp.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
lsp.jdtls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'jdtls' },
})
lsp.vimls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.terraformls.setup({
  on_attach = with_no_lspfmt,
  capabilities = capabilities,
})

-- UI

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = 'single',
  }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = 'single',
  }
)
