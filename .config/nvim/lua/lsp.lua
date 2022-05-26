-- locals
local opts = { noremap = true, silent = true }

-- nvim-lspconfig

local lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<Cr>', opts)
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
  buf_set_keymap('i', '<M-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
  buf_set_keymap('n', '<Leader>lr', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
  buf_set_keymap('n', '<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', opts)
  buf_set_keymap('n', '<Leader>lA', '<Cmd>lua vim.lsp.buf.range_code_action()<Cr>', opts)
  buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<Cr>', opts)
  buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<Cr>', opts)

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

  -- signature help
  require('lsp_signature').on_attach({
      bind = true,
      doc_lines = 10,
      floating_window = true,
      fix_pos = false,
      hint_enable = true,
      hint_prefix = require('config').sign.hint..' ',
      use_lspsaga = false,
      handler_opts = {
        border = 'single',
      },
      decorator = { '`', '`' },
    })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lsp providers

lsp.ccls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    cache = {
      directory = '/tmp/ccls-cache',
    },
  },
}
lsp.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.rls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
  },
}
lsp.denols.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
  init_options = { enable = true, lint = true, unstable = true },
}
lsp.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern('package.json'),
}
lsp.dartls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.vuels.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.svelte.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.jdtls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'jdtls' },
}
lsp.vimls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.terraformls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- lsp provider lua

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

lsp.sumneko_lua.setup{
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- UI

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = 'single',
  }
)
