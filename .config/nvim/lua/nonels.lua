local M = {}

M.setup = function()
  local nls = require('null-ls')
  local is_deno = function(utils)
    return utils.root_has_file({ 'deno.json', 'deno.jsonc' })
  end
  local is_ts = function(utils)
    return utils.root_has_file({ 'package.json' })
  end
  nls.setup({
    sources = {
      -- c/c++/c#/java
      nls.builtins.formatting.clang_format,
      -- rust
      nls.builtins.formatting.rustfmt,
      -- go
      nls.builtins.diagnostics.staticcheck,
      nls.builtins.formatting.goimports,
      -- zig
      nls.builtins.formatting.zigfmt,
      -- javascript, typescript, jsx, tsx, vue
      nls.builtins.formatting.prettier.with({ condition = is_ts, only_local = 'node_modules/.bin' }),
      -- css,sass,scss,less
      nls.builtins.diagnostics.stylelint,
      nls.builtins.formatting.stylelint.with({ only_local = 'node_modules/.bin' }),
      -- deno
      nls.builtins.formatting.deno_fmt.with({ condition = is_deno }),
      -- dart
      nls.builtins.formatting.dart_format,
      -- python
      nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.mypy,
      nls.builtins.diagnostics.ruff,
      nls.builtins.formatting.black.with({ only_local = '.venv/bin' }),
      nls.builtins.formatting.isort.with({ only_local = '.venv/bin' }),
      nls.builtins.formatting.ruff_format.with({ only_local = '.venv/bin' }),
      -- lua
      nls.builtins.formatting.stylua,
      -- editorconfig
      nls.builtins.diagnostics.editorconfig_checker,
      -- dotenv
      nls.builtins.diagnostics.dotenv_linter,
      -- json
      nls.builtins.diagnostics.jsonlint,
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
