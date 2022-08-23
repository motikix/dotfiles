-- locals
local opts = require('config').opts

-- nvim-lspconfig

local lsp = require('lspconfig')

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<Cr>', opts)
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
  buf_set_keymap('n', '<Leader>lr', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
  buf_set_keymap('n', '<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
  buf_set_keymap('n', '<Leader>lA', '<Cmd>lua vim.lsp.buf.range_code_action()<Cr>', opts)

  -- document highlighting
  if client.server_capabilities.documentHighlightProvider then
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
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
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
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.zls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.denols.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
  init_options = { enable = true, lint = true, unstable = true },
})
lsp.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern('package.json'),
})
lsp.dartls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.vuels.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.svelte.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.astro.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.pyright.setup({
  on_attach = on_attach,
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
local os = vim.fn.has('mac') == 1 and 'mac' or (vim.fn.has('linux') == 1 and 'linux' or 'windows')
lsp.java_language_server.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { vim.env.HOME .. '/.local/src/github.com/georgewfraser/java-language-server/dist/lang_server_' .. os .. '.sh' },
})
lsp.vimls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp.terraformls.setup({
  on_attach = on_attach,
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
