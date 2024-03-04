local M = {}

local opts = require('config').opts
local lsp = require('lspconfig')

M.format_enabled = true

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
M.on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<Cr>', opts)
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
  buf_set_keymap('n', '<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
  buf_set_keymap('n', '<Leader>lf', '<Cmd>lua vim.lsp.buf.format()<Cr>', opts)

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
    -- toggle formatting
    vim.api.nvim_create_user_command('ToggleFormatting', function()
      M.format_enabled = not M.format_enabled
      vim.notify(string.format('ToggleFormatting: %s', M.format_enabled))
    end, {})
    vim.api.nvim_set_keymap('n', '<Leader>tf', ':ToggleFormatting<CR>', opts)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          filter = function()
            return M.format_enabled
          end,
          bufnr = bufnr,
        })
      end,
    })
  end
end

M.setup = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- lsp providers

  lsp.clangd.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.gopls.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.rust_analyzer.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.zls.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.tsserver.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
    root_dir = lsp.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json'),
    single_file_support = false,
  })
  lsp.tailwindcss.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.prismals.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.denols.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
    root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
    init_options = {
      enable = true,
      lint = true,
      unstable = true,
      suggest = {
        imports = {
          hosts = {
            ['https://deno.land'] = true,
            ['https://cdn.nest.land'] = true,
            ['https://crux.land'] = true,
          },
        },
      },
    },
  })
  lsp.dartls.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.vuels.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.svelte.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.astro.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.pyright.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.lua_ls.setup({
    on_attach = M.on_attach,
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
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  })
  lsp.vimls.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.terraformls.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
  })
  lsp.jsonls.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  })
  lsp.yamlls.setup({
    on_attach = M.on_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  })

  -- UI

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'single',
  })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'single',
  })
end

return M
