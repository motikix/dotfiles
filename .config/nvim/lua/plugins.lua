local opts = require('config').opts
local opts_silent = require('config').opts_silent
local sign = require('config').sign

return {
  -- Color
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.catppuccin_flavour = 'mocha'
    end,
    config = function()
      require('catppuccin').setup({
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = true,
        },
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
          functions = { 'italic' },
          keywords = { 'italic' },
          types = { 'italic' },
        },
        integrations = {
          bufferline = true,
          cmp = true,
          gitsigns = true,
          hop = true,
          indent_blankline = {
            enabled = true,
            scope_color = 'mauve',
            colored_indent_levels = false,
          },
          lsp_trouble = true,
          markdown = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            inlay_hints = {
              background = true,
            },
          },
          neotree = true,
          noice = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },

  -- UI
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>tn', ':Noice<CR>', opts)
    end,
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },

  -- Explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    init = function()
      vim.api.nvim_set_keymap('n', '\\', ':Neotree reveal toggle<CR>', opts)
    end,
    opts = {
      window = {
        position = 'current',
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },

  -- Window
  {
    'yorickpeterse/nvim-window',
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>w', ':lua require("nvim-window").pick()<CR>', opts)
    end,
    opts = {
      chars = { 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l' },
    },
  },

  -- Buffer
  { 'tiagovla/scope.nvim' },
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>bd', ':bw<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>bad', ':bufdo :bw<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>bD', ':Bwipeout<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>baD', ':bufdo :Bwipeout<CR>', opts)
    end,
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'catppuccin/nvim',
    },
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>bs', ':BufferLinePick<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>bp', ':BufferLineCyclePrev<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>bn', ':BufferLineCycleNext<CR>', opts)
      vim.api.nvim_set_keymap('n', '<M-,>', ':BufferLineCyclePrev<CR>', opts)
      vim.api.nvim_set_keymap('n', '<M-.>', ':BufferLineCycleNext<CR>', opts)
      vim.api.nvim_set_keymap('n', '<M-<>', ':BufferLineMovePrev<CR>', opts)
      vim.api.nvim_set_keymap('n', '<M->>', ':BufferLineMoveNext<CR>', opts)
    end,
    config = function()
      require('bufferline').setup({
        highlights = require('catppuccin.groups.integrations.bufferline').get(),
        options = {
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(_, _, diagnostics_dict, _)
            local s = ' '
            local ws = ' '
            for e, n in pairs(diagnostics_dict) do
              local sym = e == 'error' and sign.error .. ws or (e == 'warning' and sign.warn .. ws or sign.info .. ws)
              s = s .. n .. sym
            end
            return s
          end,
          custom_filter = function(buf_number)
            if vim.bo[buf_number].filetype ~= 'qf' then
              return true
            end
          end,
          separator_style = 'slant',
        },
      })
    end,
  },

  -- Statusline
  {
    'feline-nvim/feline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'catppuccin/nvim',
    },
    config = function()
      local ctp_feline = require('catppuccin.groups.integrations.feline')
      require('feline').setup({
        components = ctp_feline.get(),
      })
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'yioneko/nvim-yati',
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
    },
    config = function()
      require('treesitter')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      enable = true,
    },
  },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          termfinder = {
            mappings = {
              rename_term = '<C-r>',
              delete_term = '<C-x>',
              vertical_term = '<C-v>',
              horizontal_term = '<C-h>',
              float_term = '<C-f>',
            },
          },
        },
      })
      telescope.load_extension('fzf')

      -- common finders
      vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope current_buffer_fuzzy_find theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap(
        'n',
        '<Leader>ff',
        ':Telescope find_files find_command=rg,--files theme=get_ivy<CR>',
        opts
      )
      vim.api.nvim_set_keymap(
        'n',
        '<Leader>fF',
        ':Telescope find_files find_command=rg,--ignore,--hidden,--files theme=get_ivy<CR>',
        opts
      )
      vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fc', ':Telescope command_history theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fs', ':Telescope search_history theme=get_ivy<CR>', opts)
      -- tree sitter
      vim.api.nvim_set_keymap('n', '<Leader>ts', ':Telescope treesitter theme=get_ivy<CR>', opts)
    end,
  },

  -- Git Support
  {
    'lewis6991/gitsigns.nvim',
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>gq', ':Gitsigns setqflist<CR>', opts)
    end,
    opts = {
      trouble = true,
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, _opts)
          _opts = _opts or {}
          _opts.buffer = bufnr
          vim.keymap.set(mode, l, r, _opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        map('n', '<Leader>gp', gs.preview_hunk)
        map('n', '<Leader>gbp', function()
          gs.blame_line({ full = true })
        end)
      end,
    },
  },
  {
    'FabijanZulj/blame.nvim',
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>gbb', ':BlameToggle<CR>', opts)
    end,
    config = true,
  },
  {
    'akinsho/git-conflict.nvim',
    opts = {
      disable_diagnostics = true,
    },
  },

  -- Editor Support
  {
    'm-demare/hlargs.nvim',
    dependencies = {
      'catppuccin/nvim',
    },
    config = function()
      require('hlargs').setup({
        color = require('catppuccin.palettes').get_palette('mocha').red,
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = { enabled = true },
    },
  },
  {
    'yamatsum/nvim-cursorline',
    opts = {
      cursorline = {
        enable = false,
      },
      cursorword = {
        enable = true,
      },
    },
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    init = function()
      vim.api.nvim_set_keymap('n', 's', ':HopChar2<CR>', opts)
      vim.api.nvim_set_keymap('n', 'S', ':HopChar2MW<CR>', opts)
      -- use `<Cmd>lua` instead of `:lua`
      -- https://github.com/phaazon/hop.nvim/issues/89#issuecomment-854701856
      vim.api.nvim_set_keymap(
        '',
        'f',
        '<Cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true })<CR>',
        opts
      )
      vim.api.nvim_set_keymap(
        '',
        'F',
        '<Cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>',
        opts
      )
      vim.api.nvim_set_keymap(
        '',
        't',
        '<Cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<CR>',
        opts
      )
      vim.api.nvim_set_keymap(
        '',
        'T',
        '<Cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<CR>',
        opts
      )
    end,
    config = true,
  },
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>tc', ':TodoTrouble<CR>', opts)
    end,
    config = true,
  },
  {
    'windwp/nvim-autopairs',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    init = function()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    end,
    opts = {
      disable_filetype = { 'TelescopePrompt', 'vim' },
      check_ts = true,
      map_cr = true,
      map_bs = true,
      map_c_h = true,
      map_c_w = true,
    },
  },
  { 'gpanders/editorconfig.nvim' },
  { 'tpope/vim-surround' },
  { 'andymass/vim-matchup' },
  {
    'norcalli/nvim-colorizer.lua',
    opts = { '*' },
  },
  {
    'petertriho/nvim-scrollbar',
    dependencies = { 'kevinhwang91/nvim-hlslens', 'lewis6991/gitsigns.nvim' },
    init = function()
      vim.api.nvim_set_keymap(
        'n',
        'n',
        [[:execute('normal! ' . v:count1 . 'n')<CR>:lua require('hlslens').start()<CR>]],
        opts
      )
      vim.api.nvim_set_keymap(
        'n',
        'N',
        [[:execute('normal! ' . v:count1 . 'N')<CR>:lua require('hlslens').start()<CR>]],
        opts
      )
    end,
    config = function()
      require('scrollbar').setup()
      require('scrollbar.handlers.search').setup()
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
  {
    'haya14busa/vim-asterisk',
    dependencies = { 'kevinhwang91/nvim-hlslens' },
    config = function()
      vim.api.nvim_set_keymap('n', '*', [[<Plug>(asterisk-z*):lua require('hlslens').start()<CR>]], opts_silent)
      vim.api.nvim_set_keymap('n', '#', [[<Plug>(asterisk-z#):lua require('hlslens').start()<CR>]], opts_silent)
      vim.api.nvim_set_keymap('n', 'g*', [[<Plug>(asterisk-gz*):lua require('hlslens').start()<CR>]], opts_silent)
      vim.api.nvim_set_keymap('n', 'g#', [[<Plug>(asterisk-gz#):lua require('hlslens').start()<CR>]], opts_silent)
      vim.api.nvim_set_keymap('x', '*', [[<Plug>(asterisk-z*):lua require('hlslens').start()<CR>]], opts_silent)
      vim.api.nvim_set_keymap('x', '#', [[<Plug>(asterisk-z#):lua require('hlslens').start()<CR>]], opts_silent)
      vim.api.nvim_set_keymap('x', 'g*', [[<Plug>(asterisk-gz*):lua require('hlslens').start()<CR>]], opts_silent)
      vim.api.nvim_set_keymap('x', 'g#', [[<Plug>(asterisk-gz#):lua require('hlslens').start()<CR>]], opts_silent)
    end,
  },
  {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>nf', ':lua require("neogen").generate()<CR>', opts)
    end,
    config = true,
  },
  {
    'yaocccc/nvim-foldsign',
    config = true,
  },
  {
    'chentoast/marks.nvim',
    opts = {
      default_mappings = true,
    },
  },
  { 'AndrewRadev/linediff.vim' },
  {
    'junegunn/vim-easy-align',
    init = function()
      vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', opts)
      vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', opts)
    end,
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = { '<Space>m', '<Space>j', '<Space>s' },
    config = true,
  },

  -- Terminal
  {
    'akinsho/nvim-toggleterm.lua',
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shade_filetypes = { 'none' },
      direction = 'float',
      float_opts = {
        border = 'curved',
        winblend = 10,
      },
      winbar = {
        enabled = true,
        name_formatter = function(term)
          return term.name
        end,
      },
    },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jay-babu/mason-null-ls.nvim',
      {
        'nvimtools/none-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvimtools/none-ls-extras.nvim' },
      },
      'folke/neodev.nvim',
      'b0o/schemastore.nvim',
    },
    config = function()
      require('mason').setup({
        log_level = vim.log.levels.INFO,
      })
      require('mason-lspconfig').setup({
        automatic_installation = true,
      })
      require('nonels').setup()
      require('mason-null-ls').setup({
        automatic_installation = true,
      })
      require('neodev').setup()
      require('lsp').setup()
      local signs = { Error = sign.error, Warn = sign.warn, Hint = sign.hint, Info = sign.info }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
  {
    'folke/lsp-trouble.nvim',
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>td', ':TroubleToggle document_diagnostics<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>tw', ':TroubleToggle workspace_diagnostics<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>tq', ':TroubleToggle quickfix<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>tl', ':TroubleToggle loclist<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gd', ':TroubleToggle lsp_definitions<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gr', ':TroubleToggle lsp_references<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gy', ':TroubleToggle lsp_type_definitions<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gi', ':TroubleToggle lsp_implementations<CR>', opts)
    end,
    config = true,
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    init = function()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = { only_current_line = true },
      })
    end,
    config = true,
  },
  {
    'smjonas/inc-rename.nvim',
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>lr', ':IncRename ', opts)
    end,
    config = true,
  },

  -- Completion
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-cmdline',
      'ray-x/cmp-treesitter',
      'onsails/lspkind-nvim',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      vim.o.completeopt = 'menu,menuone,noselect'
      local cmp = require('cmp')
      if cmp == nil then
        return
      end
      local lspkind = require('lspkind')
      lspkind.init({})
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = 'orgmode' },
          { name = 'nvim_lsp' },
          { name = 'treesitter' },
          { name = 'luasnip' },
          { name = 'emoji' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
        formatting = {
          format = function(entry, vim_item)
            return lspkind.cmp_format({
              mode = 'symbol_text',
              menu = {
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[Latex]',
                treesitter = '[TS]',
                emoji = '[Emoji]',
              },
            })(entry, vim_item)
          end,
        },
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
  },

  -- Syntax Highlight / Language Support
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = { 'markdown' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
  },
  { 'dhruvasagar/vim-table-mode' },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    event = 'VeryLazy',
    keys = {
      {
        '<Leader>vs',
        ':VenvSelect<CR>',
      },
      {
        '<Leader>vc',
        ':VenvSelectCached<CR>',
      },
    },
    opts = {
      name = { 'venv', '.venv' },
      parents = 0,
      auto_refresh = false,
    },
  },
  {
    'https://github.com/apple/pkl-neovim',
    lazy = true,
    event = 'BufReadPre *.pkl',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    build = function()
      vim.cmd('TSInstall! pkl')
    end,
  },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require('orgmode').setup({
        org_startup_indented = false,
        org_adapt_indentation = false,
        org_agenda_files = '~/.org/**/*',
        org_default_notes_file = '~/.org/refile.org',
      })
    end,
  },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('headlines').setup({
        markdown = {
          bullets = false,
          fat_headlines = false,
        },
        rmd = {
          bullets = false,
          fat_headlines = false,
        },
        norg = {
          bullets = false,
          fat_headlines = false,
        },
        org = {
          bullets = false,
          fat_headlines = false,
        },
      })
    end,
  },
  {
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh install.sh',
    config = function()
      require('sniprun').setup()
    end,
  },

  -- Rest Client
  {
    'jellydn/hurl.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = 'hurl',
    opts = {
      debug = false,
      mode = 'split',
      show_notification = true,
      auto_close = false,
      env_file = { '.env' },
      formatters = {
        json = { 'jq' },
        html = {
          'prettier',
          '--parser',
          'html',
        },
      },
    },
    keys = {
      { '<Leader>ha', ':HurlRunnerAt<CR>' },
      { '<Leader>hA', ':HurlRunner<CR>' },
      { '<Leader>hh', ':HurlRunner<CR>',  mode = 'v' },
    },
  },

  -- Misc
  { 'wsdjeg/vim-fetch' },
}
