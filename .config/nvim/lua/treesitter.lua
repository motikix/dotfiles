local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
  ensure_installed = 'all',
  playground = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<Cr>',
      scope_incremental = '<Cr>',
      node_incremental = '<Tab>',
      node_decremental = '<S-Tab>',
    },
  },
  indent = {
    enable = false,
  },
  yati = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  endwise = {
    enable = true,
  },
})
