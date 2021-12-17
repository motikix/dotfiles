-- locals
local opts = { noremap = true, silent = true }

-- nvim-lspconfig

local lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader><leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader><leader>f", "<Cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
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

-- lsp providers

lsp.ccls.setup{
  on_attach = on_attach,
  init_options = {
    cache = {
      directory = '/tmp/ccls-cache',
    },
  },
}
lsp.gopls.setup{ on_attach = on_attach }
lsp.rust_analyzer.setup{
  on_attach = on_attach,
}
lsp.denols.setup{
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern('.deno'),
  init_options = { enable = true, lint = true, unstable = true },
}
lsp.tsserver.setup{ on_attach = on_attach }
lsp.vuels.setup{ on_attach = on_attach }
-- lsp.volar.setup{ on_attach = on_attach }
lsp.svelte.setup{ on_attach = on_attach }
lsp.pyright.setup{ on_attach = on_attach }
lsp.jdtls.setup{
  on_attach = on_attach,
  cmd = { 'jdtls' },
}
lsp.vimls.setup{ on_attach = on_attach }
lsp.terraformls.setup{ on_attach = on_attach }

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
