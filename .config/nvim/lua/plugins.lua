vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()

  -- package manager
  use 'wbthomason/packer.nvim'

  use {
    'lewis6991/impatient.nvim',
    rocks = 'mpack',
  }

  -- color
  use {
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup({
        theme_style = 'dimmed',
        transparent = false,
        sidebars = { 'qf', 'vista_kind', 'terminal', 'packer', 'NvimTree' },
        dark_sidebar = true,
        dark_float = true,
      })
    end,
  }


  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('treesitter')
    end,
  }

  -- explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      local sign = require('config').sign
      vim.g.nvim_tree_quit_on_open = 1
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_hide_dotfiles = 0
      vim.g.nvim_tree_highlight_opened_files = 1
      vim.g.nvim_tree_git_hl = 1
      vim.g.nvim_tree_add_trailing = 1
      vim.g.nvim_tree_group_empty = 0
      vim.g.nvim_tree_icons = {
        lsp = {
          hint = sign.hint,
          info = sign.info,
          warning = sign.warn,
          error = sign.error,
        },
      }
      require('nvim-tree').setup({
        hijack_cursor = true,
        update_cwd = true,
        lsp_diagnostics = true,
        view = {
          width = 40,
        },
      })
      vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>NvimTreeToggle<Cr>', { noremap = true, silent = true })
    end,
  }
  use {
    'kevinhwang91/rnvimr',
    cmd = { 'RnvimrToggle' },
    setup = function()
      vim.g.rnvimr_ex_enable = 1
      vim.api.nvim_set_keymap('n', '<Leader>r', '<Cmd>RnvimrToggle<Cr>', { noremap = true, silent = true })
    end,
  }

  -- buffer
  use {
    'moll/vim-bbye',
    cmd = { 'Bdelete' },
    setup = function()
      vim.api.nvim_set_keymap('n', '<Leader>bd', '<Cmd>Bdelete<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>bad', ':bufdo :Bdelete<Cr>', { noremap = true, silent = true })
    end,
  }

  -- bufferline / statusline
  use {
    'akinsho/nvim-bufferline.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      local sign = require('config').sign
      local ws = ' '
      require('bufferline').setup{
        options = {
          custom_filter = function(buf_number)
            if vim.bo[buf_number].filetype ~= "qf" then
              return true
            end
          end,
          offsets = {
            { filetype = 'NvimTree', text = 'Explorer', highlight = 'Directory', text_align = 'left' },
            { filetype = 'vista_kind', text = 'Outline', highlight = 'Directory', text_align = 'left' },
          },
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(_, _, diagnostics_dict, _)
            local s = ' '
            for e, n in pairs(diagnostics_dict) do
              local sym = e == 'error' and sign.error..ws
                or (e == 'warning' and sign.warn..ws or sign.info..ws)
              s = s..n..sym
            end
            return s
          end,
        },
      }
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<Leader>bs', '<Cmd>BufferLinePick<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>bp', '<Cmd>BufferLineCyclePrev<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>bn', '<Cmd>BufferLineCycleNext<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<A-,>', '<Cmd>BufferLineCyclePrev<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<A-.>', '<Cmd>BufferLineCycleNext<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<A-<>', '<Cmd>BufferLineMovePrev<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<A->>', '<Cmd>BufferLineMoveNext<Cr>', opts)
    end,
  }
  use {
    'datwaft/bubbly.nvim',
    config = function()
      vim.g.bubbly_tabline = 0
      vim.g.bubbly_palette = {
        background = vim.env.BACKGROUND_COLOR,
        foreground = vim.env.FOREGROUND_COLOR,
        black = vim.env.BLACK_COLOR,
        red = vim.env.RED_COLOR,
        green = vim.env.GREEN_COLOR,
        yellow = vim.env.YELLOW_COLOR,
        blue = vim.env.BLUE_COLOR,
        purple = vim.env.MAGENTA_COLOR,
        cyan = vim.env.CYAN_COLOR,
        white = vim.env.WHITE_COLOR,
        lightgrey = '#57595e',
        darkgrey = '#404247',
      }
      vim.g.bubbly_statusline = {
        'mode',
        'total_buffer_number',

        'truncate',

        'path',
        'branch',
        'signify',
        'builtinlsp.diagnostic_count',

        'divisor',

        'filetype',
        'progress',
      }
      vim.g.bubbly_filter = {
        default = { 'qf', 'packer', 'NvimTree', 'vista_kind', 'Trouble' },
      }
    end
  }

  -- finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
    config = function()
      local opts = { noremap = true, silent = true }
      -- common finders
      vim.api.nvim_set_keymap('n', '<C-s>', '<Cmd>Telescope current_buffer_fuzzy_find theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope find_files find_command=rg,--files theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fF', '<Cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fg', '<Cmd>Telescope live_grep theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fb', '<Cmd>Telescope buffers theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fh', '<Cmd>Telescope help_tags theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fs', '<Cmd>Telescope symbols theme=get_ivy<Cr>', opts)
      -- git actions
      vim.api.nvim_set_keymap('n', '<Leader>gc', '<Cmd>Telescope git_commits theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gC', '<Cmd>Telescope git_bcommits theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gb', '<Cmd>Telescope git_branches theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gs', '<Cmd>Telescope git_status theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gS', '<Cmd>Telescope git_stash theme=get_ivy<Cr>', opts)
      -- tree sitter
      vim.api.nvim_set_keymap('n', '<Leader>ts', '<Cmd>Telescope treesitter theme=get_ivy<Cr>', opts)
      -- lsp
      vim.api.nvim_set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', 'gr', '<Cmd>Telescope lsp_references theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', 'gi', '<Cmd>Telescope lsp_implementations theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>ls', '<Cmd>Telescope lsp_document_symbols theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>lS', '<Cmd>Telescope lsp_workspace_symbols theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>la', '<Cmd>Telescope lsp_code_actions theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>lA', '<Cmd>Telescope lsp_range_code_actions theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>ld', '<Cmd>Telescope lsp_document_diagnostics theme=get_ivy<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>lD', '<Cmd>Telescope lsp_workspace_diagnostics theme=get_ivy<Cr>', opts)
    end
  }
  use {
    'nvim-telescope/telescope-symbols.nvim',
    requires = { 'nvim-telescope/telescope.nvim' }
  }

  -- list
  use {
    'Valloric/ListToggle',
    setup = function()
      vim.g.lt_location_list_toggle_map = '<Leader>ll'
      vim.g.lt_quickfix_list_toggle_map = '<Leader>qq'
    end,
  }

  -- zen
  use {
    'junegunn/goyo.vim',
    cmd = { 'Goyo' },
    setup = function()
      vim.g.goyo_width = 120
      vim.g.goyo_height = '85%'
      vim.g.goyo_linenr = 0
    end,
  }

  -- git support
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end,
  }

  -- edit support
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indent_blankline_char = '│'
      vim.g.indent_blankline_use_treesitter = true
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_current_context = true
      vim.g.indent_blankline_context_patterns = { '' }
      vim.g.indent_blankline_filetype_exclude = { 'toggleterm' }
    end,
  }
  use {
    'easymotion/vim-easymotion',
    config = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.g.EasyMotion_smartcase = 0
      vim.g.EasyMotion_use_migemo = 1
      vim.api.nvim_set_keymap('n', 's', '<Plug>(easymotion-bd-f2)', {})
      vim.api.nvim_set_keymap('n', 'S', '<Plug>(easymotion-overwin-f2)', {})
    end,
  }
  use {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDDefaultAlign = 'left'
    end,
  }
  use {
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('todo-comments').setup{}
      vim.api.nvim_set_keymap('n', '<Leader>ft', '<Cmd>TodoTelescope<Cr>', { noremap = true, silent = true })
    end,
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt" , "vim" },
        check_ts = true,
      })
      require("nvim-autopairs.completion.cmp").setup({
        map_cr = true,
        map_complete = true,
        auto_select = true,
        insert = false,
        map_char = {
          all = '(',
          tex = '{',
        },
      })
    end,
  }
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-surround'
  use 'andymass/vim-matchup'

  -- snippets
  use {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<C-f>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<C-b>'
      vim.g.UltiSnipsEditSplit = 'vertical'
    end,
  }
  use 'honza/vim-snippets'

  -- syntax check
  use {
    'dense-analysis/ale',
    config = function()
      local sign = require('config').sign
      vim.g.ale_linters = {
        javascript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescript = { 'eslint' },
        typescriptreact = { 'eslint' },
        vue = { 'eslint' },
        svelte = { 'eslint' },
        go = { 'govet' },
        rust = { 'analyzer' },
        python = { 'flake8', 'mypy' },
        terraform = { 'terraform' },
      }
      vim.g.ale_fixers = {
        javascript = { 'eslint', 'prettier' },
        javascriptreact = { 'eslint', 'prettier' },
        typescript = { 'eslint', 'prettier' },
        typescriptreact = { 'eslint', 'prettier' },
        vue = { 'eslint', 'prettier' },
        svelte = { 'eslint' },
        go = { 'goimports' },
        rust = { 'rustfmt' },
        python = { 'black', 'isort' },
        terraform = { 'terraform' },
      }
      vim.g.ale_disable_lsp = 0
      vim.g.ale_linters_explicit = 1
      vim.g.ale_sign_column_always = 1
      vim.g.ale_fix_on_save = 1
      vim.g.ale_completion_enabled = 0
      vim.g.ale_echo_msg_error_str = 'E'
      vim.g.ale_echo_msg_warning_str = 'W'
      vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
      vim.g.ale_sign_error = sign.error
      vim.g.ale_sign_warning = sign.warn
      vim.g.ale_sign_info = sign.info
      vim.g.ale_set_loclist = 1
      vim.g.ale_set_quickfix = 0
      vim.g.ale_open_list = 0
      vim.g.ale_keep_list_window_open = 0
      vim.api.nvim_set_keymap('n', ']a', '<Plug>(ale_next_wrap)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[a', '<Plug>(ale_previous_wrap)', { noremap = true, silent = true })
    end,
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require('toggleterm').setup{
        size = 20,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        direction = 'horizontal',
        shade_terminals = false,
        shade_filetypes = { 'none' },
      }
    end,
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    requires = { 'ray-x/lsp_signature.nvim' },
    config = function()
      require('lsp')
      local sign = require('config').sign
      local signs = { Error = sign.error, Warning = sign.warn, Hint = sign.hint, Information = sign.info }
      for type, icon in pairs(signs) do
        local hl = "LspDiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'quangnguyen30192/cmp-nvim-ultisnips',
    },
    config = function()
      local cmp = require'cmp'

      cmp.setup({
        completion = {
          keyword_length = 2,
        },
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          { name = 'ultisnips' },
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  }
  use {
    'onsails/lspkind-nvim',
    config = function()
      require('lspkind').init()
    end,
  }
  use {
    'folke/lsp-trouble.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('trouble').setup{}
      vim.api.nvim_set_keymap('n', '<Leader>d', '<Cmd>LspTroubleToggle lsp_document_diagnostics<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>D', '<Cmd>LspTroubleToggle lsp_workspace_diagnostics<Cr>', { noremap = true, silent = true })
    end,
  }
  use {
    'liuchengxu/vista.vim',
    cmd = { 'Vista' },
    setup = function()
      vim.g.vista_default_executive = 'nvim_lsp'
      vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
      vim.api.nvim_set_keymap('n', '<Leader>vv', '<Cmd>Vista!!<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>vf', '<Cmd>Vista finder<Cr>', { noremap = true, silent = true })
    end,
  }

  -- syntax highlight / language supports
  use {
    'sheerun/vim-polyglot',
    setup = function()
      -- disabled filetypes
      vim.g.polyglot_disabled = {}
      -- markdown behaviors
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_conceal_code_blocks = 0
      -- vue behaviors
      vim.g.vue_pre_processors = 'detect_on_enter'
    end,
  }
  use {
    'kristijanhusak/orgmode.nvim',
    config = function()
      require('orgmode').setup{}
    end,
  }
  use {
    'kovisoft/slimv',
    ft = { 'lisp' },
    setup = function()
      vim.g.slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait > /dev/null 2> /dev/null &"
      vim.g.slimv_lisp = 'ros run'
      vim.g.slimv_impl = 'sbcl'
      vim.g.slimv_repl_split = 2
    end,
  }
end)
