local M = {}

M.setup = function()
  local nls = require('null-ls')
  nls.setup({
    sources = {
      -- c/c++
      nls.builtins.formatting.clang_format,
      -- go
      nls.builtins.diagnostics.staticcheck,
      nls.builtins.formatting.goimports,
      -- gleam
      nls.builtins.formatting.gleam_format,
      -- javascript, typescript, jsx, tsx, vue
      require('none-ls.diagnostics.eslint'),
      nls.builtins.formatting.prettier,
      -- css,sass,scss,less
      nls.builtins.diagnostics.stylelint,
      nls.builtins.formatting.stylelint,
      -- dart
      nls.builtins.formatting.dart_format,
      -- python
      require('none-ls.diagnostics.ruff'),
      require('none-ls.formatting.ruff_format'),
      -- lua
      nls.builtins.formatting.stylua,
      -- editorconfig
      nls.builtins.diagnostics.editorconfig_checker,
      -- dotenv
      nls.builtins.diagnostics.dotenv_linter,
      -- yaml
      nls.builtins.diagnostics.yamllint,
      -- markdown
      nls.builtins.diagnostics.markdownlint,
      -- terraform
      nls.builtins.formatting.terraform_fmt,
    },
    on_attach = require('lsp').on_attach,
  })
end

return M
