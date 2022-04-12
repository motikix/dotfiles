local treesitter = require('nvim-treesitter.configs')

treesitter.setup{
  ensure_installed = 'all',
  highlight = {
    enable = true,
    disable = {},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
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
}
