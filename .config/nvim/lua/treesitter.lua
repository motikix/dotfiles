local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
  ensure_installed = 'all',
  sync_install = false,
  auto_install = true,
  ignore_install = { 'org' },
  modules = {},
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
  endwise = {
    enable = true,
  },
})
