vim.cmd [[packadd packer.nvim]]

require('packer').startup({
  config = {
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
    display = {
      open_fn = require('packer.util').float,
    },
  },
  function(use)
    -- package manager
    use 'wbthomason/packer.nvim'

    -- improve startup time
    use 'lewis6991/impatient.nvim'
    use 'nathom/filetype.nvim'

    -- color
    use {
      'marko-cerovac/material.nvim',
      config = function()
        vim.g.material_style = 'deep ocean'
        require('material').setup({
          contrast = {
            sidebars = true,
            floating_windows = true,
            line_numbers = true,
            sign_column = true,
            cursor_line = true,
            non_current_windows = false,
            popup_menu = true,
          },
          italics = {
            comments = true,
            keywords = true,
            functions = true,
            strings = false,
            variables = false,
          },
          contrast_filetypes = {
            'qf',
            'vista_kind',
            'terminal',
            'packer',
            'NvimTree',
            'Trouble',
          },
          high_visibility = {
            lighter = true,
            darker = true,
          },
          disable = {
            borders = true,
            background = false,
            term_colors = false,
            eob_lines = true,
          },
          lualine_style = 'default',
          async_loading = true,
          custom_highlights = {},
        })
        vim.cmd [[colorscheme material]]
      end,
    }

    -- icons
    use 'kyazdani42/nvim-web-devicons'

    -- treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('treesitter')
      end,
    }
    use 'yioneko/nvim-yati'
    use 'windwp/nvim-ts-autotag'

    -- explorer
    use {
      'kyazdani42/nvim-tree.lua',
      config = function()
        local sign = require('config').sign
        vim.g.nvim_tree_highlight_opened_files = 1
        vim.g.nvim_tree_git_hl = 1
        vim.g.nvim_tree_add_trailing = 1
        vim.g.nvim_tree_group_empty = 0
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
                    'vista_kind',
                  },
                  buftype = {
                    'terminal',
                  },
                },
              },
            },
          },
        })
        vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>NvimTreeToggle<Cr>', { noremap = true, silent = true })
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
      config = function()
        local sign = require('config').sign
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
        })
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
          'gitsigns',
          'lsp_status.diagnostics',

          'divisor',

          'filetype',
          'progress',
        }
        vim.g.bubbly_filter = {
          default = { 'qf', 'packer', 'NvimTree', 'vista_kind', 'Trouble' },
        }
        local sign = require('config').sign
        local ws = ' '
        vim.g.bubbly_symbols = {
          lsp_status = {
            diagnostics = {
              error = sign.error..ws..'%d',
              warning = sign.warn..ws..'%d',
              hint = sign.hint..ws..'%d',
              info = sign.info..ws..'%d',
            },
          },
        }
      end,
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
      end,
    }
    use {
      'nvim-telescope/telescope-symbols.nvim',
      requires = { 'nvim-telescope/telescope.nvim' }
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
        require('gitsigns').setup({
          on_attach = function(bufnr)
            local function map(mode, lhs, rhs, opts)
              opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
              vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
            end
            map('n', ']c', "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<Cr>'", { expr = true })
            map('n', '[c', "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<Cr>'", { expr = true })
          end,
        })
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
      'numToStr/Comment.nvim',
      requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
      config = function()
        require('Comment').setup({
          pre_hook = function(ctx)
            local U = require('Comment.utils')
            local location = nil
            if ctx.ctype == U.ctype.block then
              location = require('ts_context_commentstring.utils').get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require('ts_context_commentstring.utils').get_visual_start_location()
            end
            return require('ts_context_commentstring.internal').calculate_commentstring({
              key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
              location = location,
            })
          end,
        })
      end,
    }
    use {
      'folke/todo-comments.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
      config = function()
        require('todo-comments').setup()
        vim.api.nvim_set_keymap('n', '<Leader>ft', '<Cmd>TodoTelescope<Cr>', { noremap = true, silent = true })
      end,
    }
    use {
      'windwp/nvim-autopairs',
      requires = { 'hrsh7th/nvim-cmp' },
      config = function()
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
        require('nvim-autopairs').setup({
          disable_filetype = { 'TelescopePrompt' , 'vim' },
          check_ts = true,
          map_cr = true,
          map_bs = true,
          map_c_h = true,
          map_c_w = true,
        })
      end,
    }
    use 'gpanders/editorconfig.nvim'
    use 'tpope/vim-surround'
    use 'andymass/vim-matchup'
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end,
    }

    -- snippets
    use {
      'hrsh7th/vim-vsnip',
      requires = { 'rafamadriz/friendly-snippets' },
    }

    -- terminal
    use {
      'akinsho/nvim-toggleterm.lua',
      config = function()
        require('toggleterm').setup({
          size = 20,
          open_mapping = [[<C-\>]],
          hide_numbers = true,
          direction = 'horizontal',
          shade_terminals = false,
          shade_filetypes = { 'none' },
        })
      end,
    }

    -- window
    use {
      'https://gitlab.com/yorickpeterse/nvim-window.git',
      config = function()
        require('nvim-window').setup({
          chars = { 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l' },
        })
        vim.api.nvim_set_keymap('n', '<Leader>w', ':lua require("nvim-window").pick()<Cr>', { noremap = true, silent = true })
      end,
    }

    -- lsp
    use {
      'neovim/nvim-lspconfig',
      requires = { 'nvim-lua/lsp-status.nvim', 'ray-x/lsp_signature.nvim' },
      config = function()
        require('lsp')
        local sign = require('config').sign
        local signs = { Error = sign.error, Warn = sign.warn, Hint = sign.hint, Info = sign.info }
        for type, icon in pairs(signs) do
          local hl = 'DiagnosticSign' .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      end,
    }
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-path',
      },
      config = function()
        vim.o.completeopt = 'menu,menuone,noselect'
        local cmp = require('cmp')
        cmp.setup{
          completion = {
            keyword_length = 2,
          },
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
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = 'buffer' },
          }, {
            { name = 'path' },
          }),
          formatting = {
            format = function(entry, vim_item)
              vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind
              vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[Latex]',
              })[entry.source.name]
              return vim_item
            end,
          },
        }
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'cmp_git' },
          }, {
            { name = 'buffer' },
          })
        })
        cmp.setup.cmdline('/', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' },
          }
        })
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' },
          }, {
            { name = 'cmdline' },
          })
        })
      end,
    }
    use {
      'onsails/lspkind-nvim',
      config = function()
        require('lspkind').init({})
      end,
    }
    use {
      'folke/lsp-trouble.nvim',
      config = function()
        require('trouble').setup()
        vim.api.nvim_set_keymap('n', '<Leader>xd', '<Cmd>TroubleToggle document_diagnostics<Cr>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>xw', '<Cmd>TroubleToggle workspace_diagnostics<Cr>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>xl', '<Cmd>TroubleToggle loclist<Cr>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>xq', '<Cmd>TroubleToggle quickfix<Cr>', { noremap = true, silent = true })
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
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        local nls = require('null-ls')
        local is_deno = function(utils)
          return utils.root_has_file({ 'deno.json', 'deno.jsonc' })
        end
        local is_tssrv = function(utils)
          return utils.root_has_file({ 'package.json', 'tsconfig.json' })
        end
        nls.setup({
          sources = {
            -- rust
            nls.builtins.formatting.rustfmt,
            -- go
            nls.builtins.diagnostics.staticcheck,
            nls.builtins.formatting.goimports,
            -- javascript, typescript, jsx, tsx, vue
            nls.builtins.diagnostics.eslint.with({ condition = is_tssrv }),
            nls.builtins.formatting.prettier.with({ condition = is_tssrv }),
            -- css,sass,scss,less
            nls.builtins.diagnostics.stylelint,
            -- deno
            nls.builtins.formatting.deno_fmt.with({ condition = is_deno }),
            -- python
            nls.builtins.diagnostics.flake8.with({ prefer_local = true }),
            nls.builtins.diagnostics.mypy.with({ prefer_local = true }),
            nls.builtins.formatting.black.with({ prefer_local = true }),
            nls.builtins.formatting.isort.with({ prefer_local = true }),
            -- json
            nls.builtins.diagnostics.jsonlint,
            -- yaml
            nls.builtins.diagnostics.yamllint,
            -- markdown
            nls.builtins.diagnostics.markdownlint,
            -- terraform
            nls.builtins.formatting.terraform_fmt,
          },
          on_attach = function(client)
            if client.resolved_capabilities.document_formatting then
              vim.cmd([[
              augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
              augroup END
              ]])
            end
          end,
        })
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
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      ft = { 'markdown' },
      setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
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

    -- rest client
    use {
      'NTBBloodbath/rest.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      after = { 'nvim-treesitter' },
      ft = { 'http' },
      config = function()
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
        vim.api.nvim_set_keymap('n', '<Leader>rr', '<Plug>RestNvim', {})
        vim.api.nvim_set_keymap('n', '<Leader>rp', '<Plug>RestNvimPreview', {})
        vim.api.nvim_set_keymap('n', '<Leader>rl', '<Plug>RestNvimLast', {})
      end,
    }

    -- analysis
    use 'wakatime/vim-wakatime'

    -- etc
    use 'segeljakt/vim-silicon'

    require('packer_compiled')
  end,
})
