vim.cmd([[packadd packer.nvim]])

require('packer').startup({
  config = {
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
    display = {
      open_fn = require('packer.util').float,
    },
  },
  function(use)
    -- package manager
    use('wbthomason/packer.nvim')

    -- improve
    use('lewis6991/impatient.nvim')
    use('nathom/filetype.nvim')
    use('antoinemadec/FixCursorHold.nvim')

    -- project local config
    use({
      'klen/nvim-config-local',
      config = function()
        require('config-local').setup({
          config_files = { '.vimrc.lua', '.vimrc' },
          hashfile = vim.fn.stdpath('data') .. '/config-local',
          autocommands_create = true,
          commands_create = true,
          silent = false,
          lookup_parents = true,
        })
      end,
    })

    -- notification
    use({
      'rcarriga/nvim-notify',
      config = function()
        local notify = require('notify')
        notify.setup({
          background_colour = '#000000',
        })
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
        vim.notify = function(msg, ...)
          if msg:match('warning: multiple different client offset_encodings') then
            return
          end
          notify(msg, ...)
        end
      end,
    })

    -- color
    use({
      'catppuccin/nvim',
      as = 'catppuccin',
      setup = function()
        vim.g.catppuccin_flavour = 'macchiato'
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
            native_lsp = {
              enabled = true,
              underlines = {
                errors = { 'undercurl' },
                hints = { 'undercurl' },
                warnings = { 'undercurl' },
                information = { 'undercurl' },
              },
            },
            lsp_trouble = true,
            cmp = true,
            gitsigns = true,
            telescope = true,
            nvimtree = {
              transparent_panel = true,
            },
            indent_blankline = {
              enabled = true,
              colored_indent_levels = true,
            },
            bufferline = true,
            markdown = true,
            hop = true,
            notify = true,
          },
        })
        vim.cmd([[colorscheme catppuccin]])
      end,
    })
    use({
      'm-demare/hlargs.nvim',
      require = { 'nvim-treesitter/nvim-treesitter', 'catppuccin/nvim' },
      config = function()
        require('hlargs').setup({
          color = require('catppuccin.palettes').get_palette('macchiato').red
        })
      end,
    })

    -- icons
    use('kyazdani42/nvim-web-devicons')

    -- treesitter
    use({
      'nvim-treesitter/nvim-treesitter',
      requires = { 'nvim-treesitter/playground' },
      config = function()
        require('treesitter')
      end,
    })
    use({
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require('treesitter-context').setup({
          enable = true,
        })
      end,
    })
    use('yioneko/nvim-yati')
    use('windwp/nvim-ts-autotag')

    -- explorer
    use({
      'kyazdani42/nvim-tree.lua',
      config = function()
        local opts = require('config').opts
        local sign = require('config').sign
        require('nvim-tree').setup({
          hijack_cursor = true,
          update_cwd = true,
          diagnostics = {
            enable = true,
            icons = {
              hint = sign.hint,
              info = sign.info,
              warning = sign.warn,
              error = sign.error,
            },
          },
          filters = {
            dotfiles = false,
          },
          git = {
            enable = true,
            ignore = false,
          },
          view = {
            width = 40,
          },
          renderer = {
            add_trailing = true,
            group_empty = false,
            highlight_git = true,
            highlight_opened_files = 'icon',
            indent_markers = {
              enable = true,
            },
          },
          actions = {
            open_file = {
              quit_on_open = true,
              window_picker = {
                exclude = {
                  filetype = {
                    'notify',
                    'packer',
                    'qf',
                    'Trouble',
                  },
                  buftype = {
                    'terminal',
                  },
                },
              },
            },
          },
        })
        vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<Cr>', opts)
      end,
    })
    use('wsdjeg/vim-fetch')

    -- buffer
    use({
      'famiu/bufdelete.nvim',
      config = function()
        local opts = require('config').opts
        vim.api.nvim_set_keymap('n', '<Leader>bd', ':Bdelete<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>bad', ':bufdo :Bdelete<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>bD', ':bd<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>baD', ':bufdo :bd<Cr>', opts)
      end,
    })
    use({
      'beauwilliams/focus.nvim',
      config = function()
        local opts = require('config').opts
        require('focus').setup({
          signcolumn = false,
          hybridnumber = true,
          absolutenumber_unfocussed = true,
          excluded_filetypes = {
            'qf',
            'toggleterm',
            'Trouble',
          },
        })
        vim.api.nvim_set_keymap('n', '<C-w>w', ':FocusSplitNicely<Cr>', opts)
      end,
    })

    -- bufferline / statusline
    use({
      'tiagovla/scope.nvim',
      config = function()
        require('scope').setup()
      end,
    })
    use({
      'akinsho/nvim-bufferline.lua',
      config = function()
        local sign = require('config').sign
        local opts = require('config').opts
        local ws = ' '
        require('bufferline').setup({
          options = {
            custom_filter = function(buf_number)
              if vim.bo[buf_number].filetype ~= 'qf' then
                return true
              end
            end,
            offsets = {
              { filetype = 'NvimTree', text = 'Explorer', highlight = 'Directory', text_align = 'left' },
            },
            diagnostics_indicator = function(_, _, diagnostics_dict, _)
              local s = ' '
              for e, n in pairs(diagnostics_dict) do
                local sym = e == 'error' and sign.error .. ws or (e == 'warning' and sign.warn .. ws or sign.info .. ws)
                s = s .. n .. sym
              end
              return s
            end,
          },
        })
        vim.api.nvim_set_keymap('n', '<Leader>bs', ':BufferLinePick<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>bp', ':BufferLineCyclePrev<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>bn', ':BufferLineCycleNext<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<M-,>', ':BufferLineCyclePrev<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<M-.>', ':BufferLineCycleNext<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<M-<>', ':BufferLineMovePrev<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<M->>', ':BufferLineMoveNext<Cr>', opts)
      end,
    })
    use({
      'windwp/windline.nvim',
      config = function()
        require('wlsample.vscode')
      end,
    })
    use({
      'b0o/incline.nvim',
      config = function()
        require('incline').setup()
      end,
    })

    -- finder
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        'tknightz/telescope-termfinder.nvim',
      },
      config = function()
        local opts = require('config').opts
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
        telescope.load_extension('termfinder')
        telescope.load_extension('notify')

        -- common finders
        vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope current_buffer_fuzzy_find theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap(
          'n',
          '<Leader>ff',
          ':Telescope find_files find_command=rg,--files theme=get_dropdown<Cr>',
          opts
        )
        vim.api.nvim_set_keymap(
          'n',
          '<Leader>fF',
          ':Telescope find_files find_command=rg,--ignore,--hidden,--files theme=get_dropdown<Cr>',
          opts
        )
        vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>fc', ':Telescope command_history theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>fs', ':Telescope search_history theme=get_dropdown<Cr>', opts)
        -- git actions
        vim.api.nvim_set_keymap('n', '<Leader>gc', ':Telescope git_commits theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>gC', ':Telescope git_bcommits theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>gb', ':Telescope git_branches theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>gs', ':Telescope git_status theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>gS', ':Telescope git_stash theme=get_dropdown<Cr>', opts)
        -- tree sitter
        vim.api.nvim_set_keymap('n', '<Leader>ts', ':Telescope treesitter theme=get_dropdown<Cr>', opts)
        -- lsp
        vim.api.nvim_set_keymap('n', 'gd', ':Telescope lsp_definitions theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', 'gr', ':Telescope lsp_references theme=get_dropdown<Cr>', opts)
        vim.api.nvim_set_keymap('n', 'gi', ':Telescope lsp_implementations theme=get_dropdown<Cr>', opts)
        -- termfinder
        vim.api.nvim_set_keymap('n', '<Leader>tf', ':Telescope termfinder find theme=get_dropdown<Cr>', opts)
      end,
    })
    use('stevearc/dressing.nvim')

    -- zen
    use({
      'folke/zen-mode.nvim',
      config = function()
        require('zen-mode').setup()
      end,
    })
    use({
      'folke/twilight.nvim',
      config = function()
        require('twilight').setup()
      end,
    })

    -- git support
    use('tpope/vim-fugitive')
    use({
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        local mopts = require('config').opts
        require('gitsigns').setup({
          trouble = true,
          on_attach = function(bufnr)
            local function map(mode, lhs, rhs, opts)
              opts = vim.tbl_extend('force', require('config').opts, opts or {})
              vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
            end

            map('n', ']c', '&diff ? "]c" : ":Gitsigns next_hunk<Cr>"', { expr = true })
            map('n', '[c', '&diff ? "[c" : ":Gitsigns prev_hunk<Cr>"', { expr = true })
          end,
        })
        vim.api.nvim_set_keymap('n', '<Leader>gq', ':Gitsigns setqflist<Cr>', mopts)
      end,
    })
    use({
      'akinsho/git-conflict.nvim',
      config = function()
        require('git-conflict').setup({
          disable_diagnostics = true,
        })
      end,
    })

    -- edit support
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup({
          char = '|',
          use_treesitter = true,
          show_trailing_blankline_indent = false,
          show_current_context = true,
          context_patterns = { '' },
          filetype_exclude = { 'toggleterm' },
        })
      end,
    })
    use({
      'yamatsum/nvim-cursorline',
      config = function()
        require('nvim-cursorline').setup({
          cursorline = {
            enable = true,
            timeout = 500,
            number = false,
          },
        })
      end,
    })
    use({
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function()
        local opts = require('config').opts
        require('hop').setup()
        vim.api.nvim_set_keymap('n', 's', ':HopChar2<Cr>', opts)
        vim.api.nvim_set_keymap('n', 'S', ':HopChar2MW<Cr>', opts)
        -- use `<Cmd>lua` instead of `:lua`
        -- https://github.com/phaazon/hop.nvim/issues/89#issuecomment-854701856
        vim.api.nvim_set_keymap(
          '',
          'f',
          '<Cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true })<Cr>',
          opts
        )
        vim.api.nvim_set_keymap(
          '',
          'F',
          '<Cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true })<Cr>',
          opts
        )
        vim.api.nvim_set_keymap(
          '',
          't',
          '<Cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<Cr>',
          opts
        )
        vim.api.nvim_set_keymap(
          '',
          'T',
          '<Cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<Cr>',
          opts
        )
      end,
    })
    use({
      'numToStr/Comment.nvim',
      requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
      config = function()
        require('Comment').setup({
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        })
      end,
    })
    use({
      'folke/todo-comments.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
      config = function()
        local opts = require('config').opts
        require('todo-comments').setup()
        vim.api.nvim_set_keymap('n', '<Leader>tq', ':TodoTrouble<Cr>', opts)
      end,
    })
    use({
      'windwp/nvim-autopairs',
      requires = { 'hrsh7th/nvim-cmp' },
      config = function()
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
        require('nvim-autopairs').setup({
          disable_filetype = { 'TelescopePrompt', 'vim' },
          check_ts = true,
          map_cr = true,
          map_bs = true,
          map_c_h = true,
          map_c_w = true,
        })
      end,
    })
    use('gpanders/editorconfig.nvim')
    use('tpope/vim-surround')
    use('andymass/vim-matchup')
    use({
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end,
    })
    use({
      'petertriho/nvim-scrollbar',
      require = { 'kevinhwang91/nvim-hlslens' },
      config = function()
        require('scrollbar').setup()
        require('scrollbar.handlers.search').setup()
      end,
    })
    use({
      'kevinhwang91/nvim-hlslens',
      config = function()
        local opts = require('config').opts
        vim.api.nvim_set_keymap(
          'n',
          'n',
          [[:execute('normal! ' . v:count1 . 'n')<Cr>:lua require('hlslens').start()<Cr>]],
          opts
        )
        vim.api.nvim_set_keymap(
          'n',
          'N',
          [[:execute('normal! ' . v:count1 . 'N')<Cr>:lua require('hlslens').start()<Cr>]],
          opts
        )
      end,
    })
    use({
      'haya14busa/vim-asterisk',
      require = { 'kevinhwang91/nvim-hlslens' },
      config = function()
        local opts_silent = require('config').opts_silent
        vim.api.nvim_set_keymap('n', '*', [[<Plug>(asterisk-z*):lua require('hlslens').start()<Cr>]], opts_silent)
        vim.api.nvim_set_keymap('n', '#', [[<Plug>(asterisk-z#):lua require('hlslens').start()<Cr>]], opts_silent)
        vim.api.nvim_set_keymap('n', 'g*', [[<Plug>(asterisk-gz*):lua require('hlslens').start()<Cr>]], opts_silent)
        vim.api.nvim_set_keymap('n', 'g#', [[<Plug>(asterisk-gz#):lua require('hlslens').start()<Cr>]], opts_silent)
        vim.api.nvim_set_keymap('x', '*', [[<Plug>(asterisk-z*):lua require('hlslens').start()<Cr>]], opts_silent)
        vim.api.nvim_set_keymap('x', '#', [[<Plug>(asterisk-z#):lua require('hlslens').start()<Cr>]], opts_silent)
        vim.api.nvim_set_keymap('x', 'g*', [[<Plug>(asterisk-gz*):lua require('hlslens').start()<Cr>]], opts_silent)
        vim.api.nvim_set_keymap('x', 'g#', [[<Plug>(asterisk-gz#):lua require('hlslens').start()<Cr>]], opts_silent)
      end,
    })
    use({
      'danymat/neogen',
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        local opts = require('config').opts
        require('neogen').setup({})
        vim.api.nvim_set_keymap('n', '<Leader>nf', ':lua require("neogen").generate()<Cr>', opts)
      end,
    })
    use('lambdalisue/readablefold.vim')
    use({
      'chentoast/marks.nvim',
      config = function()
        require('marks').setup({
          default_mappings = true,
        })
      end,
    })
    use('haya14busa/vim-metarepeat')
    use({
      's1n7ax/nvim-comment-frame',
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('nvim-comment-frame').setup()
      end,
    })
    use('AndrewRadev/linediff.vim')
    use({
      'junegunn/vim-easy-align',
      config = function()
        local opts = require('config').opts
        vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', opts)
        vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', opts)
      end,
    })

    -- snippets
    use({
      'hrsh7th/vim-vsnip',
      requires = { 'rafamadriz/friendly-snippets' },
    })

    -- terminal
    use({
      'akinsho/nvim-toggleterm.lua',
      config = function()
        require('toggleterm').setup({
          size = 20,
          open_mapping = [[<C-\>]],
          hide_numbers = true,
          shade_terminals = true,
          shade_filetypes = { 'none' },
          direction = 'float',
          float_opts = {
            border = 'curved',
          },
        })
      end,
    })

    -- window
    use({
      'https://gitlab.com/yorickpeterse/nvim-window.git',
      config = function()
        local opts = require('config').opts
        require('nvim-window').setup({
          chars = { 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l' },
        })
        vim.api.nvim_set_keymap('n', '<Leader>w', ':lua require("nvim-window").pick()<Cr>', opts)
      end,
    })

    -- quickfix
    use({
      'stevearc/qf_helper.nvim',
      config = function()
        local opts = require('config').opts
        vim.api.nvim_set_keymap('n', '<Leader>q', ':QFToggle<Cr>', opts)
      end,
    })
    use({
      'kevinhwang91/nvim-bqf',
      requires = {
        {
          'junegunn/fzf',
          run = function()
            vim.fn['fzf#install']()
          end,
        },
        'nvim-treesitter/nvim-treesitter',
      },
      ft = 'qf',
      setup = function()
        vim.cmd([[copen]])
        vim.cmd([[cclose]])
      end,
      config = function()
        require('bqf').setup({
          auto_enable = true,
          auto_resize_height = true,
        })
      end,
    })
    use({
      'gabrielpoca/replacer.nvim',
      config = function()
        local opts = require('config').opts
        vim.api.nvim_set_keymap(
          'n',
          '<Leader>h',
          ':lua if vim.bo.filetype == "qf" then require("replacer").run({ rename_files = false }) end<Cr>',
          opts
        )
      end,
    })

    -- lsp
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('lsp')
        local sign = require('config').sign
        local signs = { Error = sign.error, Warn = sign.warn, Hint = sign.hint, Info = sign.info }
        for type, icon in pairs(signs) do
          local hl = 'DiagnosticSign' .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      end,
    })
    use({
      'onsails/lspkind-nvim',
      config = function()
        require('lspkind').init({})
      end,
    })
    use({
      'folke/lsp-trouble.nvim',
      config = function()
        local opts = require('config').opts
        require('trouble').setup()
        vim.api.nvim_set_keymap('n', '<Leader>d', ':TroubleToggle document_diagnostics<Cr>', opts)
        vim.api.nvim_set_keymap('n', '<Leader>D', ':TroubleToggle workspace_diagnostics<Cr>', opts)
      end,
    })
    use('folke/lsp-colors.nvim')
    use({
      'kosayoda/nvim-lightbulb',
      requires = { 'antoinemadec/FixCursorHold.nvim' },
      config = function()
        require('nvim-lightbulb').setup({
          autocmd = {
            enabled = true,
          },
        })
      end,
    })
    use({
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        local lsp = require('lsp')
        local nls = require('null-ls')
        local is_deno = function(utils)
          return utils.root_has_file({ 'deno.json', 'deno.jsonc' })
        end
        local is_tssrv = function(utils)
          return utils.root_has_file({ 'package.json', 'tsconfig.json' })
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
            nls.builtins.code_actions.eslint_d.with({ condition = is_tssrv }),
            nls.builtins.diagnostics.eslint_d.with({ condition = is_tssrv }),
            nls.builtins.formatting.eslint_d.with({ condition = is_tssrv }),
            nls.builtins.formatting.prettierd.with({ condition = is_tssrv }),
            -- css,sass,scss,less
            nls.builtins.diagnostics.stylelint.with({ prefer_local = 'node_modules/.bin' }),
            nls.builtins.formatting.stylelint.with({ prefer_local = 'node_modules/.bin' }),
            -- deno
            nls.builtins.formatting.deno_fmt.with({ condition = is_deno }),
            -- dart
            nls.builtins.formatting.dart_format,
            -- python
            nls.builtins.diagnostics.flake8.with({ prefer_local = '.venv/bin' }),
            nls.builtins.diagnostics.mypy.with({ prefer_local = '.venv/bin' }),
            nls.builtins.formatting.black.with({ prefer_local = '.venv/bin' }),
            nls.builtins.formatting.isort.with({ prefer_local = '.venv/bin' }),
            -- lua
            nls.builtins.formatting.stylua,
            -- json
            nls.builtins.diagnostics.jsonlint,
            -- yaml
            nls.builtins.diagnostics.yamllint,
            -- markdown
            nls.builtins.diagnostics.markdownlint,
            -- terraform
            nls.builtins.formatting.terraform_fmt,
          },
          on_attach = lsp.on_attach,
        })
      end,
    })

    -- completion
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-emoji',
        'ray-x/cmp-treesitter',
      },
      config = function()
        vim.o.completeopt = 'menu,menuone,noselect'
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        cmp.setup({
          snippet = {
            expand = function(args)
              vim.fn['vsnip#anonymous'](args.body)
            end,
          },
          view = {
            entries = 'native',
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<Cr>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = 'emoji' },
            { name = 'treesitter' },
            { name = 'nvim_lsp_signature_help' },
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
      end,
    })
    use({
      'gelguy/wilder.nvim',
      config = function()
        local wilder = require('wilder')
        wilder.setup({
          modes = { ':', '/', '?' },
          next_key = '<C-n>',
          previous_key = '<C-p>',
        })
        wilder.set_option('pipeline', {
          wilder.branch(
            wilder.cmdline_pipeline({
              language = 'python',
              fuzzy = 1,
            }),
            wilder.python_search_pipeline({
              pattern = wilder.python_fuzzy_pattern(),
              sorter = wilder.python_difflib_sorter(),
              engine = 're',
            })
          ),
        })
        wilder.set_option(
          'renderer',
          wilder.popupmenu_renderer({
            highlighter = wilder.basic_highlighter(),
            highlights = {
              accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
            },
            left = { ' ', wilder.popupmenu_devicons() },
            right = { ' ', wilder.popupmenu_scrollbar() },
          })
        )
      end,
    })

    -- syntax highlight / language supports
    use({
      'sheerun/vim-polyglot',
      setup = function()
        -- disabled filetypes
        vim.g.polyglot_disabled = {}
        -- vue behaviors
        vim.g.vue_pre_processors = 'detect_on_enter'
        -- markdown behaviors
        vim.g.vim_markdown_conceal = 0
        vim.g.vim_markdown_math = 1
        vim.g.vim_markdown_frontmatter = 1
        vim.g.vim_markdown_toml_frontmatter = 1
        vim.g.vim_markdown_json_frontmatter = 1
        vim.g.vim_markdown_strikethrough = 1
        -- csv behaviors
        vim.g.csv_no_conceal = 1
      end,
    })
    use({
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install']()
      end,
      ft = { 'markdown' },
      setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
    })
    use('dhruvasagar/vim-table-mode')
    use({
      'kovisoft/slimv',
      ft = { 'lisp' },
      setup = function()
        vim.g.slimv_swank_cmd = '!ros -e "(ql:quickload :swank) (swank:create-server)" wait > /dev/null 2> /dev/null &'
        vim.g.slimv_lisp = 'ros run'
        vim.g.slimv_impl = 'sbcl'
        vim.g.slimv_repl_split = 2
      end,
    })

    -- rest client
    use({
      'NTBBloodbath/rest.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      after = { 'nvim-treesitter' },
      ft = { 'http' },
      config = function()
        local opts_silent = require('config').opts_silent
        require('rest-nvim').setup({
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
        })
        vim.api.nvim_set_keymap('n', '<Leader>rr', '<Plug>RestNvim', opts_silent)
        vim.api.nvim_set_keymap('n', '<Leader>rp', '<Plug>RestNvimPreview', opts_silent)
        vim.api.nvim_set_keymap('n', '<Leader>rl', '<Plug>RestNvimLast', opts_silent)
      end,
    })

    -- analysis
    use('wakatime/vim-wakatime')

    -- etc
    use('segeljakt/vim-silicon')

    require('packer_compiled')
  end,
})
