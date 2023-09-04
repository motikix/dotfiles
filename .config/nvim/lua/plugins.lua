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
        term_colors = true,
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
          functions = { 'italic' },
          keywords = { 'italic' },
          types = { 'italic' },
        },
        integrations = {
          treesitter = true,
          treesitter_context = true,
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
          lsp_trouble = true,
          cmp = true,
          gitsigns = true,
          telescope = true,
          fern = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          bufferline = true,
          markdown = true,
          hop = true,
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },

  -- Explorer
  {
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/fern-hijack.vim',
      'lambdalisue/fern-git-status.vim',
      'TheLeoP/fern-renderer-web-devicons.nvim',
      'nvim-tree/nvim-web-devicons',
      'yuki-yano/fern-preview.vim',
    },
    init = function()
      vim.g['fern#renderer'] = 'nvim-web-devicons'
      vim.g['fern#default_hidden'] = 1
      vim.api.nvim_set_keymap('n', '-', ':Fern . -reveal=%<CR>', opts)
      vim.api.nvim_set_keymap('n', '_', ':Fern %:h<CR>', opts)
      vim.cmd([[
        function! s:fern_settings() abort
          nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
        endfunction

        augroup fern-settings
          autocmd!
          autocmd FileType fern call s:fern_settings()
        augroup END
      ]])
    end,
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
      -- git actions
      vim.api.nvim_set_keymap('n', '<Leader>gc', ':Telescope git_commits theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gC', ':Telescope git_bcommits theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gb', ':Telescope git_branches theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gs', ':Telescope git_status theme=get_ivy<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gS', ':Telescope git_stash theme=get_ivy<CR>', opts)
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
        map('n', '<Leader>hp', gs.preview_hunk)
        map('n', '<Leader>hb', function()
          gs.blame_line({ full = true })
        end)
      end,
    },
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
    opts = {
      char = '|',
      use_treesitter = true,
      show_trailing_blankline_indent = false,
      show_current_context = true,
      context_patterns = { '' },
      filetype_exclude = { 'toggleterm' },
    },
  },
  {
    'yamatsum/nvim-cursorline',
    opts = {
      cursorline = {
        enable = true,
        timeout = 500,
        number = false,
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
      require('nvim-treesitter.configs').setup({
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
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
      vim.api.nvim_set_keymap('n', '<Leader>tq', ':TodoTrouble<CR>', opts)
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
    'anuvyklack/pretty-fold.nvim',
    config = true,
  },
  {
    'anuvyklack/fold-preview.nvim',
    dependencies = 'anuvyklack/keymap-amend.nvim',
    opts = {
      auto = 400,
    },
  },
  {
    'yaocccc/nvim-foldsign',
    event = 'CursorHold',
    config = true,
  },
  {
    'chentoast/marks.nvim',
    opts = {
      default_mappings = true,
    },
  },
  {
    's1n7ax/nvim-comment-frame',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      keymap = '<Leader>cf',
      multiline_keymap = '<Leader>cm',
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

  -- Quickfix
  {
    'stevearc/qf_helper.nvim',
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>q', ':QFToggle<CR>', opts)
    end,
    config = true,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    init = function()
      vim.cmd([[copen]])
      vim.cmd([[cclose]])
    end,
    opts = {
      auto_enable = true,
      auto_resize_height = true,
    },
  },
  {
    'yorickpeterse/nvim-pqf',
    config = true,
  },
  {
    'stefandtw/quickfix-reflector.vim',
    init = function()
      vim.g.qf_modifiable = 1
      vim.g.qf_join_changes = 1
      vim.g.qf_write_changes = 1
    end,
  },

  -- Snippets
  {
    'hrsh7th/vim-vsnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
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

  -- Linter & Fixer
  {
    'dense-analysis/ale',
    init = function()
      vim.g.ale_echo_cursor = 0
      vim.g.ale_fix_on_save = 1
      vim.g.ale_disable_lsp = 1
      vim.g.ale_linters_explicit = 1
      vim.g.ale_sign_column_always = 1
      vim.g.ale_use_neovim_diagnostics_api = 1
      vim.g.ale_virtualtext_cursor = 'disabled'

      vim.g.ale_linters = {
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        css = { 'stylelint' },
        sass = { 'stylelint' },
        scss = { 'stylelint' },
        less = { 'stylelint' },
        python = { 'flake8', 'mypy' },
        go = { 'staticcheck' },
        json = { 'jsonlint' },
        yaml = { 'yamllint' },
        markdown = { 'markdownlint' },
      }
      vim.g.ale_fixers = {
        lua = { 'stylua' },
        javascript = { 'eslint', 'prettier' },
        typescript = { 'eslint', 'prettier' },
        css = { 'prettier' },
        sass = { 'prettier' },
        scss = { 'prettier' },
        less = { 'prettier' },
        deno = { 'deno' },
        python = { 'isort', 'black' },
        go = { 'goimports' },
        rust = { 'rustfmt' },
        terraform = { 'terraform' },
      }

      vim.g.ale_lua_stylua_options = '-s'
      vim.g.ale_python_auto_pipenv = 1
      vim.g.ale_python_auto_poetry = 1
      vim.g.ale_python_auto_virtualenv = 1
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'b0o/schemastore.nvim' },
    config = function()
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
      vim.api.nvim_set_keymap('n', '<Leader>d', ':TroubleToggle document_diagnostics<CR>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>D', ':TroubleToggle workspace_diagnostics<CR>', opts)
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
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'emoji' },
          { name = 'treesitter' },
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
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
                vsnip = '[VSnip]',
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

  -- Rest Client
  {
    'NTBBloodbath/rest.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      vim.api.nvim_set_keymap('n', '<Leader>rr', '<Plug>RestNvim', opts_silent)
      vim.api.nvim_set_keymap('n', '<Leader>rp', '<Plug>RestNvimPreview', opts_silent)
      vim.api.nvim_set_keymap('n', '<Leader>rl', '<Plug>RestNvimLast', opts_silent)
    end,
    opts = {
      result_split_horizontal = false,
      skip_ssl_verification = true,
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    },
  },

  -- Misc
  { 'wsdjeg/vim-fetch' },
}
