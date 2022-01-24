-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/syuni/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/syuni/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/syuni/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/syuni/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/syuni/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\1\2§\3\0\1\a\0\18\00004\1\0\0%\2\1\0>\1\2\2)\2\0\0007\3\2\0007\4\2\0017\4\3\4\5\3\4\0T\3\a€4\3\0\0%\4\4\0>\3\2\0027\3\5\3>\3\1\2\16\2\3\0T\3\16€7\3\6\0007\4\6\0017\4\a\4\4\3\4\0T\3\5€7\3\6\0007\4\6\0017\4\b\4\5\3\4\0T\3\6€4\3\0\0%\4\4\0>\3\2\0027\3\t\3>\3\1\2\16\2\3\0004\3\0\0%\4\n\0>\3\2\0027\3\v\0033\4\14\0007\5\2\0007\6\2\0017\6\f\6\5\5\6\0T\5\2€%\5\r\0T\6\1€%\5\15\0:\5\16\4:\2\17\4@\3\2\0\rlocation\bkey\16__multiline\1\0\0\14__default\tline\28calculate_commentstring&ts_context_commentstring.internal\30get_visual_start_location\6V\6v\fcmotion\24get_cursor_location#ts_context_commentstring.utils\nblock\nctype\18Comment.utils\frequireN\1\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0001\2\3\0:\2\5\1>\0\2\1G\0\1\0\rpre_hook\1\0\0\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ale = {
    config = { "\27LJ\1\2÷\n\0\0\6\0E\0\0014\0\0\0%\1\1\0>\0\2\0027\0\2\0004\1\3\0007\1\4\0013\2\a\0003\3\6\0:\3\b\0023\3\t\0:\3\n\0023\3\v\0:\3\f\0023\3\r\0:\3\14\0023\3\15\0:\3\16\0023\3\17\0:\3\18\0023\3\19\0:\3\20\0023\3\21\0:\3\22\0023\3\23\0:\3\24\0023\3\25\0:\3\26\2:\2\5\0014\1\3\0007\1\4\0013\2\29\0003\3\28\0:\3\b\0023\3\30\0:\3\n\0023\3\31\0:\3\f\0023\3 \0:\3\14\0023\3!\0:\3\16\0023\3\"\0:\3\18\0023\3#\0:\3\20\0023\3$\0:\3\22\0023\3%\0:\3\24\0023\3&\0:\3\26\2:\2\27\0014\1\3\0007\1\4\1'\2\0\0:\2'\0014\1\3\0007\1\4\1'\2\1\0:\2(\0014\1\3\0007\1\4\1'\2\1\0:\2)\0014\1\3\0007\1\4\1'\2\1\0:\2*\0014\1\3\0007\1\4\1'\2\0\0:\2+\0014\1\3\0007\1\4\1%\2-\0:\2,\0014\1\3\0007\1\4\1%\2/\0:\2.\0014\1\3\0007\1\4\1%\0021\0:\0020\0014\1\3\0007\1\4\0017\0023\0:\0022\0014\1\3\0007\1\4\0017\0025\0:\0024\0014\1\3\0007\1\4\0017\0027\0:\0026\0014\1\3\0007\1\4\1'\2\1\0:\0028\0014\1\3\0007\1\4\1'\2\0\0:\0029\0014\1\3\0007\1\4\1'\2\0\0:\2:\0014\1\3\0007\1\4\1'\2\0\0:\2;\0014\1\3\0007\1<\0017\1=\1%\2>\0%\3?\0%\4@\0003\5A\0>\1\5\0014\1\3\0007\1<\0017\1=\1%\2>\0%\3B\0%\4C\0003\5D\0>\1\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\30<Plug>(ale_previous_wrap)\a[a\1\0\2\fnoremap\2\vsilent\2\26<Plug>(ale_next_wrap)\a]a\6n\20nvim_set_keymap\bapi\30ale_keep_list_window_open\18ale_open_list\21ale_set_quickfix\20ale_set_loclist\tinfo\18ale_sign_info\twarn\21ale_sign_warning\nerror\19ale_sign_error\31[%linter%] %s [%severity%]\24ale_echo_msg_format\6W\29ale_echo_msg_warning_str\6E\27ale_echo_msg_error_str\27ale_completion_enabled\20ale_fix_on_save\27ale_sign_column_always\25ale_linters_explicit\20ale_disable_lsp\1\2\0\0\14terraform\1\3\0\0\nblack\nisort\1\2\0\0\frustfmt\1\2\0\0\14goimports\1\2\0\0\veslint\1\3\0\0\veslint\rprettier\1\3\0\0\veslint\rprettier\1\3\0\0\veslint\rprettier\1\3\0\0\veslint\rprettier\1\0\0\1\3\0\0\veslint\rprettier\15ale_fixers\14terraform\1\2\0\0\14terraform\vpython\1\3\0\0\vflake8\tmypy\trust\1\2\0\0\brls\ago\1\2\0\0\ngovet\vsvelte\1\2\0\0\veslint\bvue\1\2\0\0\veslint\20typescriptreact\1\2\0\0\veslint\15typescript\1\2\0\0\veslint\20javascriptreact\1\2\0\0\veslint\15javascript\1\0\0\1\2\0\0\veslint\16ale_linters\6g\bvim\tsign\vconfig\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/ale",
    url = "https://github.com/dense-analysis/ale"
  },
  ["bubbly.nvim"] = {
    config = { "\27LJ\1\2°\a\0\0\t\0000\0\\4\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0003\1\6\0004\2\0\0007\2\4\0027\2\5\2:\2\a\0014\2\0\0007\2\4\0027\2\b\2:\2\t\0014\2\0\0007\2\4\0027\2\n\2:\2\v\0014\2\0\0007\2\4\0027\2\f\2:\2\r\0014\2\0\0007\2\4\0027\2\14\2:\2\15\0014\2\0\0007\2\4\0027\2\16\2:\2\17\0014\2\0\0007\2\4\0027\2\18\2:\2\19\0014\2\0\0007\2\4\0027\2\20\2:\2\21\0014\2\0\0007\2\4\0027\2\22\2:\2\23\0014\2\0\0007\2\4\0027\2\24\2:\2\25\1:\1\3\0004\0\0\0007\0\1\0003\1\27\0:\1\26\0004\0\0\0007\0\1\0003\1\30\0003\2\29\0:\2\31\1:\1\28\0004\0 \0%\1!\0>\0\2\0027\0\"\0%\1#\0004\2\0\0007\2\1\0023\3.\0003\4,\0003\5'\0007\6%\0\16\a\1\0%\b&\0$\6\b\6:\6%\0057\6(\0\16\a\1\0%\b&\0$\6\b\6:\6)\0057\6*\0\16\a\1\0%\b&\0$\6\b\6:\6*\0057\6+\0\16\a\1\0%\b&\0$\6\b\6:\6+\5:\5-\4:\4/\3:\3$\2G\0\1\0\15lsp_status\1\0\0\16diagnostics\1\0\0\tinfo\thint\fwarning\twarn\1\0\0\a%d\nerror\19bubbly_symbols\6 \tsign\vconfig\frequire\fdefault\1\0\0\1\6\0\0\aqf\vpacker\rNvimTree\15vista_kind\fTrouble\18bubbly_filter\1\v\0\0\tmode\24total_buffer_number\rtruncate\tpath\vbranch\rgitsigns\27lsp_status.diagnostics\fdivisor\rfiletype\rprogress\22bubbly_statusline\nwhite\16WHITE_COLOR\tcyan\15CYAN_COLOR\vpurple\18MAGENTA_COLOR\tblue\15BLUE_COLOR\vyellow\17YELLOW_COLOR\ngreen\16GREEN_COLOR\bred\14RED_COLOR\nblack\16BLACK_COLOR\15foreground\21FOREGROUND_COLOR\15background\1\0\2\14lightgrey\f#57595e\rdarkgrey\f#404247\21BACKGROUND_COLOR\benv\19bubbly_palette\19bubbly_tabline\6g\bvim\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/bubbly.nvim",
    url = "https://github.com/datwaft/bubbly.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["github-nvim-theme"] = {
    config = { "\27LJ\1\2¿\1\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\rsidebars\1\a\0\0\aqf\15vista_kind\rterminal\vpacker\rNvimTree\fTrouble\1\0\4\16transparent\1\15dark_float\2\16theme_style\vdimmed\17dark_sidebar\2\nsetup\17github-theme\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2:\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    commands = { "Goyo" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/opt/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\1\2Ù\2\0\0\2\0\v\0\0254\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0)\1\2\0:\1\4\0004\0\0\0007\0\1\0)\1\1\0:\1\5\0004\0\0\0007\0\1\0)\1\2\0:\1\6\0004\0\0\0007\0\1\0003\1\b\0:\1\a\0004\0\0\0007\0\1\0003\1\n\0:\1\t\0G\0\1\0\1\2\0\0\15toggleterm&indent_blankline_filetype_exclude\1\2\0\0\5&indent_blankline_context_patterns*indent_blankline_show_current_context4indent_blankline_show_trailing_blankline_indent$indent_blankline_use_treesitter\bâ”‚\26indent_blankline_char\6g\bvim\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp-trouble.nvim"] = {
    config = { "\27LJ\1\2ç\3\0\0\5\0\19\0'4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\a\0%\3\b\0003\4\t\0>\0\5\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\n\0%\3\v\0003\4\f\0>\0\5\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\r\0%\3\14\0003\4\15\0>\0\5\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\16\0%\3\17\0003\4\18\0>\0\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2$<Cmd>TroubleToggle quickfix<Cr>\15<Leader>xq\1\0\2\fnoremap\2\vsilent\2#<Cmd>TroubleToggle loclist<Cr>\15<Leader>xl\1\0\2\fnoremap\2\vsilent\0021<Cmd>TroubleToggle workspace_diagnostics<Cr>\15<Leader>xw\1\0\2\fnoremap\2\vsilent\0020<Cmd>TroubleToggle document_diagnostics<Cr>\15<Leader>xd\6n\20nvim_set_keymap\bapi\bvim\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim",
    url = "https://github.com/folke/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\1\0024\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  neorg = {
    config = { "\27LJ\1\2Ý\2\0\0\6\0\20\0\0274\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\18\0003\2\3\0002\3\0\0:\3\4\0023\3\6\0003\4\5\0:\4\a\3:\3\b\0022\3\0\0:\3\t\0023\3\r\0003\4\v\0003\5\n\0:\5\f\4:\4\a\3:\3\14\0023\3\16\0003\4\15\0:\4\a\3:\3\17\2:\2\19\1>\0\2\1G\0\1\0\tload\1\0\0\25core.norg.completion\1\0\0\1\0\1\vengine\rnvim-cmp\21core.norg.dirman\1\0\0\15workspaces\1\0\0\1\0\1\17my_workspace\f~/neorg\24core.norg.concealer\18core.keybinds\vconfig\1\0\0\1\0\2\21default_keybinds\2\17neorg_leader\14<Leader>o\18core.defaults\1\0\0\nsetup\nneorg\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/opt/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  ["nvim-autopairs"] = {
    config = { '\27LJ\1\2‹\2\0\0\5\0\f\0\0224\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0027\1\3\1\16\2\1\0007\1\4\1%\3\5\0007\4\6\0>\4\1\0=\1\2\0014\1\0\0%\2\a\0>\1\2\0027\1\b\0013\2\n\0003\3\t\0:\3\v\2>\1\2\1G\0\1\0\21disable_filetype\1\0\3\rcheck_ts\2\vmap_bs\2\fmap_c_w\2\1\3\0\0\20TelescopePrompt\bvim\nsetup\19nvim-autopairs\20on_confirm_done\17confirm_done\aon\nevent\bcmp"nvim-autopairs.completion.cmp\frequire\0' },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\1\2>\0\1\2\0\4\0\t4\1\0\0007\1\1\0016\1\0\0017\1\2\1\6\1\3\0T\1\2€)\1\2\0H\1\2\0G\0\1\0\aqf\rfiletype\abo\bvim«\1\0\4\14\2\6\0 %\4\0\0004\5\1\0\16\6\2\0>\5\2\4D\b\24€\a\b\2\0T\n\6€+\n\0\0007\n\2\n+\v\1\0$\n\v\n\14\0\n\0T\v\f€\a\b\3\0T\n\6€+\n\0\0007\n\4\n+\v\1\0$\n\v\n\14\0\n\0T\v\4€+\n\0\0007\n\5\n+\v\1\0$\n\v\n\16\v\4\0\16\f\t\0\16\r\n\0$\4\r\vB\b\3\3N\bæH\4\2\0\0À\1À\tinfo\twarn\fwarning\nerror\npairs\6 Ç\6\1\0\b\0!\0R4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0004\2\0\0%\3\4\0>\2\2\0027\2\5\0023\3\14\0003\4\a\0001\5\6\0:\5\b\0042\5\3\0003\6\t\0;\6\1\0053\6\n\0;\6\2\5:\5\v\0041\5\f\0:\5\r\4:\4\15\3>\2\2\0013\2\16\0004\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\21\0%\6\22\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\23\0%\6\24\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\25\0%\6\26\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\27\0%\6\24\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\28\0%\6\26\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\29\0%\6\30\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\31\0%\6 \0\16\a\2\0>\3\5\0010\0\0€G\0\1\0 <Cmd>BufferLineMoveNext<Cr>\n<A->> <Cmd>BufferLineMovePrev<Cr>\n<A-<>\n<A-.>\n<A-,>!<Cmd>BufferLineCycleNext<Cr>\15<Leader>bn!<Cmd>BufferLineCyclePrev<Cr>\15<Leader>bp\28<Cmd>BufferLinePick<Cr>\15<Leader>bs\6n\20nvim_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\2\foptions\1\0\0\26diagnostics_indicator\0\foffsets\1\0\4\ttext\fOutline\14highlight\14Directory\15text_align\tleft\rfiletype\15vista_kind\1\0\4\ttext\rExplorer\14highlight\14Directory\15text_align\tleft\rfiletype\rNvimTree\18custom_filter\1\0\1\16diagnostics\rnvim_lsp\0\nsetup\15bufferline\6 \tsign\vconfig\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\1\2;\0\1\3\0\4\0\0064\1\0\0007\1\1\0017\1\2\0017\2\3\0>\1\2\1G\0\1\0\tbody\20vsnip#anonymous\afn\bvimÜ\1\0\2\5\0\n\0\0174\2\1\0%\3\2\0>\2\2\0027\2\3\0027\2\4\0027\3\0\0016\2\3\2%\3\5\0007\4\0\1$\2\4\2:\2\0\0013\2\a\0007\3\b\0007\3\t\0036\2\3\2:\2\6\1H\1\2\0\tname\vsource\1\0\5\rnvim_lua\n[Lua]\rnvim_lsp\n[LSP]\vbuffer\r[Buffer]\18latex_symbols\f[Latex]\fluasnip\14[LuaSnip]\tmenu\6 \fdefault\fpresets\flspkind\frequire\tkindÒ\3\1\0\6\0\31\00044\0\0\0%\1\1\0>\0\2\0027\1\2\0003\2\4\0003\3\3\0:\3\5\0023\3\a\0001\4\6\0:\4\b\3:\3\t\0023\3\f\0007\4\n\0007\4\v\4'\5üÿ>\4\2\2:\4\r\0037\4\n\0007\4\v\4'\5\4\0>\4\2\2:\4\14\0037\4\n\0007\4\15\4>\4\1\2:\4\16\0037\4\n\0007\4\17\4>\4\1\2:\4\18\0037\4\n\0007\4\19\0043\5\20\0>\4\2\2:\4\21\3:\3\n\0022\3\5\0003\4\22\0;\4\1\0033\4\23\0;\4\2\0033\4\24\0;\4\3\0033\4\25\0;\4\4\3:\3\26\0023\3\28\0001\4\27\0:\4\29\3:\3\30\2>\1\2\1G\0\1\0\15formatting\vformat\1\0\0\0\fsources\1\0\1\tname\nneorg\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\1\0\1\tname\vbuffer\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\fmapping\fsnippet\vexpand\1\0\0\0\15completion\1\0\0\1\0\1\19keyword_length\3\2\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\2•\2\0\0\v\0\22\0#4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\0027\0\3\0003\1\5\0007\2\4\0:\2\6\0017\2\a\0:\2\b\0017\2\t\0:\2\n\0017\2\v\0:\2\f\0014\2\r\0\16\3\1\0>\2\2\4D\5\f€%\a\14\0\16\b\5\0$\a\b\a4\b\15\0007\b\16\b7\b\17\b\16\t\a\0003\n\18\0:\6\19\n:\a\20\n:\a\21\n>\b\3\1B\5\3\3N\5òG\0\1\0\nnumhl\vtexthl\ttext\1\0\0\16sign_define\afn\bvim\19DiagnosticSign\npairs\tInfo\tinfo\tHint\thint\tWarn\twarn\nError\1\0\0\nerror\tsign\vconfig\blsp\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-toggleterm.lua"] = {
    config = { "\27LJ\1\2®\1\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\20shade_filetypes\1\2\0\0\tnone\1\0\5\20shade_terminals\1\17open_mapping\n<C-\\>\14direction\15horizontal\tsize\3\20\17hide_numbers\2\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\1\2œ\6\0\0\6\0)\0E4\0\0\0%\1\1\0>\0\2\0027\0\2\0004\1\3\0007\1\4\1'\2\1\0:\2\5\0014\1\3\0007\1\4\1'\2\1\0:\2\6\0014\1\3\0007\1\4\1'\2\1\0:\2\a\0014\1\3\0007\1\4\1'\2\1\0:\2\b\0014\1\3\0007\1\4\1'\2\1\0:\2\t\0014\1\3\0007\1\4\1'\2\0\0:\2\n\0014\1\3\0007\1\4\0013\2\r\0003\3\f\0:\3\14\0023\3\15\0:\3\16\2:\2\v\0014\1\0\0%\2\17\0>\1\2\0027\1\18\0013\2\19\0003\3\20\0003\4\22\0007\5\21\0:\5\21\0047\5\23\0:\5\23\0047\5\24\0:\5\25\0047\5\26\0:\5\26\4:\4\27\3:\3\28\0023\3\29\0:\3\30\0023\3\31\0:\3 \0023\3!\0:\3\"\2>\1\2\0014\1\3\0007\1#\0017\1$\1%\2%\0%\3&\0%\4'\0003\5(\0>\1\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\28<Cmd>NvimTreeToggle<Cr>\n<C-n>\6n\20nvim_set_keymap\bapi\tview\1\0\1\nwidth\3(\bgit\1\0\2\vignore\1\venable\2\ffilters\1\0\1\rdotfiles\1\16diagnostics\nicons\nerror\fwarning\twarn\tinfo\1\0\0\thint\1\0\1\venable\2\1\0\2\15update_cwd\2\18hijack_cursor\2\nsetup\14nvim-tree\fbuftype\1\2\0\0\rterminal\rfiletype\1\0\0\1\6\0\0\vnotify\vpacker\aqf\fTrouble\15vista_kind$nvim_tree_window_picker_exclude\26nvim_tree_group_empty\27nvim_tree_add_trailing\21nvim_tree_git_hl%nvim_tree_highlight_opened_files\29nvim_tree_indent_markers\27nvim_tree_quit_on_open\6g\bvim\tsign\vconfig\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "neorg", "rest.nvim" },
    loaded = true,
    only_config = true
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["rest.nvim"] = {
    config = { "\27LJ\1\2ò\3\0\0\5\0\19\0%4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\0012\2\0\0:\2\b\1>\0\2\0014\0\t\0007\0\n\0007\0\v\0%\1\f\0%\2\r\0%\3\14\0002\4\0\0>\0\5\0014\0\t\0007\0\n\0007\0\v\0%\1\f\0%\2\15\0%\3\16\0002\4\0\0>\0\5\0014\0\t\0007\0\n\0007\0\v\0%\1\f\0%\2\17\0%\3\18\0002\4\0\0>\0\5\1G\0\1\0\23<Plug>RestNvimLast\15<Leader>rl\26<Plug>RestNvimPreview\15<Leader>rp\19<Plug>RestNvim\15<Leader>rr\6n\20nvim_set_keymap\bapi\bvim\29custom_dynamic_variables\vresult\1\0\3\rshow_url\2\17show_headers\2\19show_http_info\2\14highlight\1\0\2\fenabled\2\ftimeout\3–\1\1\0\5\20jump_to_request\1\26skip_ssl_verification\2\28result_split_horizontal\1\17yank_dry_run\2\renv_file\t.env\nsetup\14rest-nvim\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/opt/rest.nvim",
    url = "https://github.com/NTBBloodbath/rest.nvim"
  },
  slimv = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/opt/slimv",
    url = "https://github.com/kovisoft/slimv"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\1\2¾\16\0\0\6\0001\0²\0013\0\0\0004\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\5\0%\4\6\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\a\0%\4\b\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\t\0%\4\n\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\v\0%\4\f\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\r\0%\4\14\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\15\0%\4\16\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\17\0%\4\18\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\19\0%\4\20\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\21\0%\4\22\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\23\0%\4\24\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\25\0%\4\26\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\27\0%\4\28\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\29\0%\4\30\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\31\0%\4 \0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3!\0%\4\"\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3#\0%\4$\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3%\0%\4&\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3'\0%\4(\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3)\0%\4*\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3+\0%\4,\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3-\0%\4.\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3/\0%\0040\0\16\5\0\0>\1\5\1G\0\1\0?<Cmd>Telescope lsp_workspace_diagnostics theme=get_ivy<Cr>\15<Leader>lD><Cmd>Telescope lsp_document_diagnostics theme=get_ivy<Cr>\15<Leader>ld<<Cmd>Telescope lsp_range_code_actions theme=get_ivy<Cr>\15<Leader>lA6<Cmd>Telescope lsp_code_actions theme=get_ivy<Cr>\15<Leader>la;<Cmd>Telescope lsp_workspace_symbols theme=get_ivy<Cr>\15<Leader>lS:<Cmd>Telescope lsp_document_symbols theme=get_ivy<Cr>\15<Leader>ls9<Cmd>Telescope lsp_implementations theme=get_ivy<Cr>\agi4<Cmd>Telescope lsp_references theme=get_ivy<Cr>\agr5<Cmd>Telescope lsp_definitions theme=get_ivy<Cr>\agd0<Cmd>Telescope treesitter theme=get_ivy<Cr>\15<Leader>ts/<Cmd>Telescope git_stash theme=get_ivy<Cr>\15<Leader>gS0<Cmd>Telescope git_status theme=get_ivy<Cr>\15<Leader>gs2<Cmd>Telescope git_branches theme=get_ivy<Cr>\15<Leader>gb2<Cmd>Telescope git_bcommits theme=get_ivy<Cr>\15<Leader>gC1<Cmd>Telescope git_commits theme=get_ivy<Cr>\15<Leader>gc-<Cmd>Telescope symbols theme=get_ivy<Cr>\15<Leader>fs/<Cmd>Telescope help_tags theme=get_ivy<Cr>\15<Leader>fh-<Cmd>Telescope buffers theme=get_ivy<Cr>\15<Leader>fb/<Cmd>Telescope live_grep theme=get_ivy<Cr>\15<Leader>fgZ<Cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files theme=get_ivy<Cr>\15<Leader>fFH<Cmd>Telescope find_files find_command=rg,--files theme=get_ivy<Cr>\15<Leader>ff?<Cmd>Telescope current_buffer_fuzzy_find theme=get_ivy<Cr>\n<C-s>\6n\20nvim_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\2\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\1\2¯\1\0\0\5\0\n\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\a\0%\3\b\0003\4\t\0>\0\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\27<Cmd>TodoTelescope<Cr>\15<Leader>ft\6n\20nvim_set_keymap\bapi\bvim\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["vim-bbye"] = {
    commands = { "Bdelete" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/opt/vim-bbye",
    url = "https://github.com/moll/vim-bbye"
  },
  ["vim-easymotion"] = {
    config = { "\27LJ\1\2“\2\0\0\5\0\f\0\0294\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0'\1\0\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\0\0007\0\5\0007\0\6\0%\1\a\0%\2\b\0%\3\t\0002\4\0\0>\0\5\0014\0\0\0007\0\5\0007\0\6\0%\1\a\0%\2\n\0%\3\v\0002\4\0\0>\0\5\1G\0\1\0\"<Plug>(easymotion-overwin-f2)\6S\29<Plug>(easymotion-bd-f2)\6s\6n\20nvim_set_keymap\bapi\26EasyMotion_use_migemo\25EasyMotion_smartcase\26EasyMotion_do_mapping\6g\bvim\0" },
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-polyglot"] = {
    loaded = true,
    needs_bufread = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/opt/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/start/vim-wakatime",
    url = "https://github.com/wakatime/vim-wakatime"
  },
  ["vista.vim"] = {
    commands = { "Vista" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/syuni/.local/share/nvim/site/pack/packer/opt/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: goyo.vim
time([[Setup for goyo.vim]], true)
try_loadstring("\27LJ\1\2h\0\0\2\0\6\0\r4\0\0\0007\0\1\0'\1x\0:\1\2\0004\0\0\0007\0\1\0%\1\4\0:\1\3\0004\0\0\0007\0\1\0'\1\0\0:\1\5\0G\0\1\0\16goyo_linenr\b85%\16goyo_height\15goyo_width\6g\bvim\0", "setup", "goyo.vim")
time([[Setup for goyo.vim]], false)
-- Setup for: markdown-preview.nvim
time([[Setup for markdown-preview.nvim]], true)
try_loadstring("\27LJ\1\2=\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\2\0\0\rmarkdown\19mkdp_filetypes\6g\bvim\0", "setup", "markdown-preview.nvim")
time([[Setup for markdown-preview.nvim]], false)
-- Setup for: vista.vim
time([[Setup for vista.vim]], true)
try_loadstring("\27LJ\1\2¹\2\0\0\5\0\15\0\0254\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0003\1\5\0:\1\4\0004\0\0\0007\0\6\0007\0\a\0%\1\b\0%\2\t\0%\3\n\0003\4\v\0>\0\5\0014\0\0\0007\0\6\0007\0\a\0%\1\b\0%\2\f\0%\3\r\0003\4\14\0>\0\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\26<Cmd>Vista finder<Cr>\15<Leader>vf\1\0\2\fnoremap\2\vsilent\2\21<Cmd>Vista!!<Cr>\15<Leader>vv\6n\20nvim_set_keymap\bapi\1\3\0\0\15â•°â”€â–¸ \15â”œâ”€â–¸ \22vista_icon_indent\rnvim_lsp\28vista_default_executive\6g\bvim\0", "setup", "vista.vim")
time([[Setup for vista.vim]], false)
-- Setup for: neorg
time([[Setup for neorg]], true)
try_loadstring("\27LJ\1\2ã\3\0\0\4\0\17\0\0244\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\0023\1\a\0003\2\4\0003\3\5\0:\3\6\2:\2\b\1:\1\3\0003\1\f\0003\2\n\0003\3\v\0:\3\6\2:\2\b\1:\1\t\0003\1\16\0003\2\14\0003\3\15\0:\3\6\2:\2\b\1:\1\r\0G\0\1\0\1\0\0\1\2\0\0\17src/parser.c\1\0\2\burl9https://github.com/nvim-neorg/tree-sitter-norg-table\vbranch\tmain\15norg_table\1\0\0\1\2\0\0\17src/parser.c\1\0\2\burl8https://github.com/nvim-neorg/tree-sitter-norg-meta\vbranch\tmain\14norg_meta\17install_info\1\0\0\nfiles\1\3\0\0\17src/parser.c\19src/scanner.cc\1\0\2\burl3https://github.com/nvim-neorg/tree-sitter-norg\vbranch\tmain\tnorg\23get_parser_configs\28nvim-treesitter.parsers\frequire\0", "setup", "neorg")
time([[Setup for neorg]], false)
-- Setup for: slimv
time([[Setup for slimv]], true)
try_loadstring("\27LJ\1\2ë\1\0\0\2\0\t\0\0174\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0004\0\0\0007\0\1\0%\1\a\0:\1\6\0004\0\0\0007\0\1\0'\1\2\0:\1\b\0G\0\1\0\21slimv_repl_split\tsbcl\15slimv_impl\fros run\15slimv_lispZ!ros -e '(ql:quickload :swank) (swank:create-server)' wait > /dev/null 2> /dev/null &\20slimv_swank_cmd\6g\bvim\0", "setup", "slimv")
time([[Setup for slimv]], false)
-- Setup for: vim-polyglot
time([[Setup for vim-polyglot]], true)
try_loadstring("\27LJ\1\2å\1\0\0\2\0\b\0\0174\0\0\0007\0\1\0003\1\3\0:\1\2\0004\0\0\0007\0\1\0'\1\0\0:\1\4\0004\0\0\0007\0\1\0'\1\0\0:\1\5\0004\0\0\0007\0\1\0%\1\a\0:\1\6\0G\0\1\0\20detect_on_enter\23vue_pre_processors%vim_markdown_conceal_code_blocks\25vim_markdown_conceal\1\5\0\0\15autoindent\15javascript\15typescript\bjsx\22polyglot_disabled\6g\bvim\0", "setup", "vim-polyglot")
time([[Setup for vim-polyglot]], false)
time([[packadd for vim-polyglot]], true)
vim.cmd [[packadd vim-polyglot]]
time([[packadd for vim-polyglot]], false)
-- Setup for: vim-bbye
time([[Setup for vim-bbye]], true)
try_loadstring("\27LJ\1\2É\1\0\0\5\0\n\0\0174\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\4\0%\3\5\0003\4\6\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\a\0%\3\b\0003\4\t\0>\0\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\24:bufdo :Bdelete<Cr>\16<Leader>bad\1\0\2\fnoremap\2\vsilent\2\21<Cmd>Bdelete<Cr>\15<Leader>bd\6n\20nvim_set_keymap\bapi\bvim\0", "setup", "vim-bbye")
time([[Setup for vim-bbye]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\1\2*\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\15treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\1\2;\0\1\3\0\4\0\0064\1\0\0007\1\1\0017\1\2\0017\2\3\0>\1\2\1G\0\1\0\tbody\20vsnip#anonymous\afn\bvimÜ\1\0\2\5\0\n\0\0174\2\1\0%\3\2\0>\2\2\0027\2\3\0027\2\4\0027\3\0\0016\2\3\2%\3\5\0007\4\0\1$\2\4\2:\2\0\0013\2\a\0007\3\b\0007\3\t\0036\2\3\2:\2\6\1H\1\2\0\tname\vsource\1\0\5\rnvim_lua\n[Lua]\rnvim_lsp\n[LSP]\vbuffer\r[Buffer]\18latex_symbols\f[Latex]\fluasnip\14[LuaSnip]\tmenu\6 \fdefault\fpresets\flspkind\frequire\tkindÒ\3\1\0\6\0\31\00044\0\0\0%\1\1\0>\0\2\0027\1\2\0003\2\4\0003\3\3\0:\3\5\0023\3\a\0001\4\6\0:\4\b\3:\3\t\0023\3\f\0007\4\n\0007\4\v\4'\5üÿ>\4\2\2:\4\r\0037\4\n\0007\4\v\4'\5\4\0>\4\2\2:\4\14\0037\4\n\0007\4\15\4>\4\1\2:\4\16\0037\4\n\0007\4\17\4>\4\1\2:\4\18\0037\4\n\0007\4\19\0043\5\20\0>\4\2\2:\4\21\3:\3\n\0022\3\5\0003\4\22\0;\4\1\0033\4\23\0;\4\2\0033\4\24\0;\4\3\0033\4\25\0;\4\4\3:\3\26\0023\3\28\0001\4\27\0:\4\29\3:\3\30\2>\1\2\1G\0\1\0\15formatting\vformat\1\0\0\0\fsources\1\0\1\tname\nneorg\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\1\0\1\tname\vbuffer\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\fmapping\fsnippet\vexpand\1\0\0\0\15completion\1\0\0\1\0\1\19keyword_length\3\2\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\1\2Ù\2\0\0\2\0\v\0\0254\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0)\1\2\0:\1\4\0004\0\0\0007\0\1\0)\1\1\0:\1\5\0004\0\0\0007\0\1\0)\1\2\0:\1\6\0004\0\0\0007\0\1\0003\1\b\0:\1\a\0004\0\0\0007\0\1\0003\1\n\0:\1\t\0G\0\1\0\1\2\0\0\15toggleterm&indent_blankline_filetype_exclude\1\2\0\0\5&indent_blankline_context_patterns*indent_blankline_show_current_context4indent_blankline_show_trailing_blankline_indent$indent_blankline_use_treesitter\bâ”‚\26indent_blankline_char\6g\bvim\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: ale
time([[Config for ale]], true)
try_loadstring("\27LJ\1\2÷\n\0\0\6\0E\0\0014\0\0\0%\1\1\0>\0\2\0027\0\2\0004\1\3\0007\1\4\0013\2\a\0003\3\6\0:\3\b\0023\3\t\0:\3\n\0023\3\v\0:\3\f\0023\3\r\0:\3\14\0023\3\15\0:\3\16\0023\3\17\0:\3\18\0023\3\19\0:\3\20\0023\3\21\0:\3\22\0023\3\23\0:\3\24\0023\3\25\0:\3\26\2:\2\5\0014\1\3\0007\1\4\0013\2\29\0003\3\28\0:\3\b\0023\3\30\0:\3\n\0023\3\31\0:\3\f\0023\3 \0:\3\14\0023\3!\0:\3\16\0023\3\"\0:\3\18\0023\3#\0:\3\20\0023\3$\0:\3\22\0023\3%\0:\3\24\0023\3&\0:\3\26\2:\2\27\0014\1\3\0007\1\4\1'\2\0\0:\2'\0014\1\3\0007\1\4\1'\2\1\0:\2(\0014\1\3\0007\1\4\1'\2\1\0:\2)\0014\1\3\0007\1\4\1'\2\1\0:\2*\0014\1\3\0007\1\4\1'\2\0\0:\2+\0014\1\3\0007\1\4\1%\2-\0:\2,\0014\1\3\0007\1\4\1%\2/\0:\2.\0014\1\3\0007\1\4\1%\0021\0:\0020\0014\1\3\0007\1\4\0017\0023\0:\0022\0014\1\3\0007\1\4\0017\0025\0:\0024\0014\1\3\0007\1\4\0017\0027\0:\0026\0014\1\3\0007\1\4\1'\2\1\0:\0028\0014\1\3\0007\1\4\1'\2\0\0:\0029\0014\1\3\0007\1\4\1'\2\0\0:\2:\0014\1\3\0007\1\4\1'\2\0\0:\2;\0014\1\3\0007\1<\0017\1=\1%\2>\0%\3?\0%\4@\0003\5A\0>\1\5\0014\1\3\0007\1<\0017\1=\1%\2>\0%\3B\0%\4C\0003\5D\0>\1\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\30<Plug>(ale_previous_wrap)\a[a\1\0\2\fnoremap\2\vsilent\2\26<Plug>(ale_next_wrap)\a]a\6n\20nvim_set_keymap\bapi\30ale_keep_list_window_open\18ale_open_list\21ale_set_quickfix\20ale_set_loclist\tinfo\18ale_sign_info\twarn\21ale_sign_warning\nerror\19ale_sign_error\31[%linter%] %s [%severity%]\24ale_echo_msg_format\6W\29ale_echo_msg_warning_str\6E\27ale_echo_msg_error_str\27ale_completion_enabled\20ale_fix_on_save\27ale_sign_column_always\25ale_linters_explicit\20ale_disable_lsp\1\2\0\0\14terraform\1\3\0\0\nblack\nisort\1\2\0\0\frustfmt\1\2\0\0\14goimports\1\2\0\0\veslint\1\3\0\0\veslint\rprettier\1\3\0\0\veslint\rprettier\1\3\0\0\veslint\rprettier\1\3\0\0\veslint\rprettier\1\0\0\1\3\0\0\veslint\rprettier\15ale_fixers\14terraform\1\2\0\0\14terraform\vpython\1\3\0\0\vflake8\tmypy\trust\1\2\0\0\brls\ago\1\2\0\0\ngovet\vsvelte\1\2\0\0\veslint\bvue\1\2\0\0\veslint\20typescriptreact\1\2\0\0\veslint\15typescript\1\2\0\0\veslint\20javascriptreact\1\2\0\0\veslint\15javascript\1\0\0\1\2\0\0\veslint\16ale_linters\6g\bvim\tsign\vconfig\frequire\0", "config", "ale")
time([[Config for ale]], false)
-- Config for: lsp-trouble.nvim
time([[Config for lsp-trouble.nvim]], true)
try_loadstring("\27LJ\1\2ç\3\0\0\5\0\19\0'4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\a\0%\3\b\0003\4\t\0>\0\5\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\n\0%\3\v\0003\4\f\0>\0\5\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\r\0%\3\14\0003\4\15\0>\0\5\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\16\0%\3\17\0003\4\18\0>\0\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2$<Cmd>TroubleToggle quickfix<Cr>\15<Leader>xq\1\0\2\fnoremap\2\vsilent\2#<Cmd>TroubleToggle loclist<Cr>\15<Leader>xl\1\0\2\fnoremap\2\vsilent\0021<Cmd>TroubleToggle workspace_diagnostics<Cr>\15<Leader>xw\1\0\2\fnoremap\2\vsilent\0020<Cmd>TroubleToggle document_diagnostics<Cr>\15<Leader>xd\6n\20nvim_set_keymap\bapi\bvim\nsetup\ftrouble\frequire\0", "config", "lsp-trouble.nvim")
time([[Config for lsp-trouble.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring('\27LJ\1\2‹\2\0\0\5\0\f\0\0224\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0027\1\3\1\16\2\1\0007\1\4\1%\3\5\0007\4\6\0>\4\1\0=\1\2\0014\1\0\0%\2\a\0>\1\2\0027\1\b\0013\2\n\0003\3\t\0:\3\v\2>\1\2\1G\0\1\0\21disable_filetype\1\0\3\rcheck_ts\2\vmap_bs\2\fmap_c_w\2\1\3\0\0\20TelescopePrompt\bvim\nsetup\19nvim-autopairs\20on_confirm_done\17confirm_done\aon\nevent\bcmp"nvim-autopairs.completion.cmp\frequire\0', "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
try_loadstring("\27LJ\1\2®\1\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\20shade_filetypes\1\2\0\0\tnone\1\0\5\20shade_terminals\1\17open_mapping\n<C-\\>\14direction\15horizontal\tsize\3\20\17hide_numbers\2\nsetup\15toggleterm\frequire\0", "config", "nvim-toggleterm.lua")
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\1\2¾\16\0\0\6\0001\0²\0013\0\0\0004\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\5\0%\4\6\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\a\0%\4\b\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\t\0%\4\n\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\v\0%\4\f\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\r\0%\4\14\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\15\0%\4\16\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\17\0%\4\18\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\19\0%\4\20\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\21\0%\4\22\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\23\0%\4\24\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\25\0%\4\26\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\27\0%\4\28\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\29\0%\4\30\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3\31\0%\4 \0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3!\0%\4\"\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3#\0%\4$\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3%\0%\4&\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3'\0%\4(\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3)\0%\4*\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3+\0%\4,\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3-\0%\4.\0\16\5\0\0>\1\5\0014\1\1\0007\1\2\0017\1\3\1%\2\4\0%\3/\0%\0040\0\16\5\0\0>\1\5\1G\0\1\0?<Cmd>Telescope lsp_workspace_diagnostics theme=get_ivy<Cr>\15<Leader>lD><Cmd>Telescope lsp_document_diagnostics theme=get_ivy<Cr>\15<Leader>ld<<Cmd>Telescope lsp_range_code_actions theme=get_ivy<Cr>\15<Leader>lA6<Cmd>Telescope lsp_code_actions theme=get_ivy<Cr>\15<Leader>la;<Cmd>Telescope lsp_workspace_symbols theme=get_ivy<Cr>\15<Leader>lS:<Cmd>Telescope lsp_document_symbols theme=get_ivy<Cr>\15<Leader>ls9<Cmd>Telescope lsp_implementations theme=get_ivy<Cr>\agi4<Cmd>Telescope lsp_references theme=get_ivy<Cr>\agr5<Cmd>Telescope lsp_definitions theme=get_ivy<Cr>\agd0<Cmd>Telescope treesitter theme=get_ivy<Cr>\15<Leader>ts/<Cmd>Telescope git_stash theme=get_ivy<Cr>\15<Leader>gS0<Cmd>Telescope git_status theme=get_ivy<Cr>\15<Leader>gs2<Cmd>Telescope git_branches theme=get_ivy<Cr>\15<Leader>gb2<Cmd>Telescope git_bcommits theme=get_ivy<Cr>\15<Leader>gC1<Cmd>Telescope git_commits theme=get_ivy<Cr>\15<Leader>gc-<Cmd>Telescope symbols theme=get_ivy<Cr>\15<Leader>fs/<Cmd>Telescope help_tags theme=get_ivy<Cr>\15<Leader>fh-<Cmd>Telescope buffers theme=get_ivy<Cr>\15<Leader>fb/<Cmd>Telescope live_grep theme=get_ivy<Cr>\15<Leader>fgZ<Cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files theme=get_ivy<Cr>\15<Leader>fFH<Cmd>Telescope find_files find_command=rg,--files theme=get_ivy<Cr>\15<Leader>ff?<Cmd>Telescope current_buffer_fuzzy_find theme=get_ivy<Cr>\n<C-s>\6n\20nvim_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\2\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\1\2œ\6\0\0\6\0)\0E4\0\0\0%\1\1\0>\0\2\0027\0\2\0004\1\3\0007\1\4\1'\2\1\0:\2\5\0014\1\3\0007\1\4\1'\2\1\0:\2\6\0014\1\3\0007\1\4\1'\2\1\0:\2\a\0014\1\3\0007\1\4\1'\2\1\0:\2\b\0014\1\3\0007\1\4\1'\2\1\0:\2\t\0014\1\3\0007\1\4\1'\2\0\0:\2\n\0014\1\3\0007\1\4\0013\2\r\0003\3\f\0:\3\14\0023\3\15\0:\3\16\2:\2\v\0014\1\0\0%\2\17\0>\1\2\0027\1\18\0013\2\19\0003\3\20\0003\4\22\0007\5\21\0:\5\21\0047\5\23\0:\5\23\0047\5\24\0:\5\25\0047\5\26\0:\5\26\4:\4\27\3:\3\28\0023\3\29\0:\3\30\0023\3\31\0:\3 \0023\3!\0:\3\"\2>\1\2\0014\1\3\0007\1#\0017\1$\1%\2%\0%\3&\0%\4'\0003\5(\0>\1\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\28<Cmd>NvimTreeToggle<Cr>\n<C-n>\6n\20nvim_set_keymap\bapi\tview\1\0\1\nwidth\3(\bgit\1\0\2\vignore\1\venable\2\ffilters\1\0\1\rdotfiles\1\16diagnostics\nicons\nerror\fwarning\twarn\tinfo\1\0\0\thint\1\0\1\venable\2\1\0\2\15update_cwd\2\18hijack_cursor\2\nsetup\14nvim-tree\fbuftype\1\2\0\0\rterminal\rfiletype\1\0\0\1\6\0\0\vnotify\vpacker\aqf\fTrouble\15vista_kind$nvim_tree_window_picker_exclude\26nvim_tree_group_empty\27nvim_tree_add_trailing\21nvim_tree_git_hl%nvim_tree_highlight_opened_files\29nvim_tree_indent_markers\27nvim_tree_quit_on_open\6g\bvim\tsign\vconfig\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: github-nvim-theme
time([[Config for github-nvim-theme]], true)
try_loadstring("\27LJ\1\2¿\1\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\rsidebars\1\a\0\0\aqf\15vista_kind\rterminal\vpacker\rNvimTree\fTrouble\1\0\4\16transparent\1\15dark_float\2\16theme_style\vdimmed\17dark_sidebar\2\nsetup\17github-theme\frequire\0", "config", "github-nvim-theme")
time([[Config for github-nvim-theme]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\1\0024\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
-- Config for: vim-easymotion
time([[Config for vim-easymotion]], true)
try_loadstring("\27LJ\1\2“\2\0\0\5\0\f\0\0294\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0'\1\0\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\0\0007\0\5\0007\0\6\0%\1\a\0%\2\b\0%\3\t\0002\4\0\0>\0\5\0014\0\0\0007\0\5\0007\0\6\0%\1\a\0%\2\n\0%\3\v\0002\4\0\0>\0\5\1G\0\1\0\"<Plug>(easymotion-overwin-f2)\6S\29<Plug>(easymotion-bd-f2)\6s\6n\20nvim_set_keymap\bapi\26EasyMotion_use_migemo\25EasyMotion_smartcase\26EasyMotion_do_mapping\6g\bvim\0", "config", "vim-easymotion")
time([[Config for vim-easymotion]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\1\2:\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\1\2¯\1\0\0\5\0\n\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\a\0%\3\b\0003\4\t\0>\0\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\27<Cmd>TodoTelescope<Cr>\15<Leader>ft\6n\20nvim_set_keymap\bapi\bvim\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\1\2>\0\1\2\0\4\0\t4\1\0\0007\1\1\0016\1\0\0017\1\2\1\6\1\3\0T\1\2€)\1\2\0H\1\2\0G\0\1\0\aqf\rfiletype\abo\bvim«\1\0\4\14\2\6\0 %\4\0\0004\5\1\0\16\6\2\0>\5\2\4D\b\24€\a\b\2\0T\n\6€+\n\0\0007\n\2\n+\v\1\0$\n\v\n\14\0\n\0T\v\f€\a\b\3\0T\n\6€+\n\0\0007\n\4\n+\v\1\0$\n\v\n\14\0\n\0T\v\4€+\n\0\0007\n\5\n+\v\1\0$\n\v\n\16\v\4\0\16\f\t\0\16\r\n\0$\4\r\vB\b\3\3N\bæH\4\2\0\0À\1À\tinfo\twarn\fwarning\nerror\npairs\6 Ç\6\1\0\b\0!\0R4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0004\2\0\0%\3\4\0>\2\2\0027\2\5\0023\3\14\0003\4\a\0001\5\6\0:\5\b\0042\5\3\0003\6\t\0;\6\1\0053\6\n\0;\6\2\5:\5\v\0041\5\f\0:\5\r\4:\4\15\3>\2\2\0013\2\16\0004\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\21\0%\6\22\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\23\0%\6\24\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\25\0%\6\26\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\27\0%\6\24\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\28\0%\6\26\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\29\0%\6\30\0\16\a\2\0>\3\5\0014\3\17\0007\3\18\0037\3\19\3%\4\20\0%\5\31\0%\6 \0\16\a\2\0>\3\5\0010\0\0€G\0\1\0 <Cmd>BufferLineMoveNext<Cr>\n<A->> <Cmd>BufferLineMovePrev<Cr>\n<A-<>\n<A-.>\n<A-,>!<Cmd>BufferLineCycleNext<Cr>\15<Leader>bn!<Cmd>BufferLineCyclePrev<Cr>\15<Leader>bp\28<Cmd>BufferLinePick<Cr>\15<Leader>bs\6n\20nvim_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\2\foptions\1\0\0\26diagnostics_indicator\0\foffsets\1\0\4\ttext\fOutline\14highlight\14Directory\15text_align\tleft\rfiletype\15vista_kind\1\0\4\ttext\rExplorer\14highlight\14Directory\15text_align\tleft\rfiletype\rNvimTree\18custom_filter\1\0\1\16diagnostics\rnvim_lsp\0\nsetup\15bufferline\6 \tsign\vconfig\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\1\2§\3\0\1\a\0\18\00004\1\0\0%\2\1\0>\1\2\2)\2\0\0007\3\2\0007\4\2\0017\4\3\4\5\3\4\0T\3\a€4\3\0\0%\4\4\0>\3\2\0027\3\5\3>\3\1\2\16\2\3\0T\3\16€7\3\6\0007\4\6\0017\4\a\4\4\3\4\0T\3\5€7\3\6\0007\4\6\0017\4\b\4\5\3\4\0T\3\6€4\3\0\0%\4\4\0>\3\2\0027\3\t\3>\3\1\2\16\2\3\0004\3\0\0%\4\n\0>\3\2\0027\3\v\0033\4\14\0007\5\2\0007\6\2\0017\6\f\6\5\5\6\0T\5\2€%\5\r\0T\6\1€%\5\15\0:\5\16\4:\2\17\4@\3\2\0\rlocation\bkey\16__multiline\1\0\0\14__default\tline\28calculate_commentstring&ts_context_commentstring.internal\30get_visual_start_location\6V\6v\fcmotion\24get_cursor_location#ts_context_commentstring.utils\nblock\nctype\18Comment.utils\frequireN\1\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0001\2\3\0:\2\5\1>\0\2\1G\0\1\0\rpre_hook\1\0\0\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: bubbly.nvim
time([[Config for bubbly.nvim]], true)
try_loadstring("\27LJ\1\2°\a\0\0\t\0000\0\\4\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0003\1\6\0004\2\0\0007\2\4\0027\2\5\2:\2\a\0014\2\0\0007\2\4\0027\2\b\2:\2\t\0014\2\0\0007\2\4\0027\2\n\2:\2\v\0014\2\0\0007\2\4\0027\2\f\2:\2\r\0014\2\0\0007\2\4\0027\2\14\2:\2\15\0014\2\0\0007\2\4\0027\2\16\2:\2\17\0014\2\0\0007\2\4\0027\2\18\2:\2\19\0014\2\0\0007\2\4\0027\2\20\2:\2\21\0014\2\0\0007\2\4\0027\2\22\2:\2\23\0014\2\0\0007\2\4\0027\2\24\2:\2\25\1:\1\3\0004\0\0\0007\0\1\0003\1\27\0:\1\26\0004\0\0\0007\0\1\0003\1\30\0003\2\29\0:\2\31\1:\1\28\0004\0 \0%\1!\0>\0\2\0027\0\"\0%\1#\0004\2\0\0007\2\1\0023\3.\0003\4,\0003\5'\0007\6%\0\16\a\1\0%\b&\0$\6\b\6:\6%\0057\6(\0\16\a\1\0%\b&\0$\6\b\6:\6)\0057\6*\0\16\a\1\0%\b&\0$\6\b\6:\6*\0057\6+\0\16\a\1\0%\b&\0$\6\b\6:\6+\5:\5-\4:\4/\3:\3$\2G\0\1\0\15lsp_status\1\0\0\16diagnostics\1\0\0\tinfo\thint\fwarning\twarn\1\0\0\a%d\nerror\19bubbly_symbols\6 \tsign\vconfig\frequire\fdefault\1\0\0\1\6\0\0\aqf\vpacker\rNvimTree\15vista_kind\fTrouble\18bubbly_filter\1\v\0\0\tmode\24total_buffer_number\rtruncate\tpath\vbranch\rgitsigns\27lsp_status.diagnostics\fdivisor\rfiletype\rprogress\22bubbly_statusline\nwhite\16WHITE_COLOR\tcyan\15CYAN_COLOR\vpurple\18MAGENTA_COLOR\tblue\15BLUE_COLOR\vyellow\17YELLOW_COLOR\ngreen\16GREEN_COLOR\bred\14RED_COLOR\nblack\16BLACK_COLOR\15foreground\21FOREGROUND_COLOR\15background\1\0\2\14lightgrey\f#57595e\rdarkgrey\f#404247\21BACKGROUND_COLOR\benv\19bubbly_palette\19bubbly_tabline\6g\bvim\0", "config", "bubbly.nvim")
time([[Config for bubbly.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\1\2•\2\0\0\v\0\22\0#4\0\0\0%\1\1\0>\0\2\0014\0\0\0%\1\2\0>\0\2\0027\0\3\0003\1\5\0007\2\4\0:\2\6\0017\2\a\0:\2\b\0017\2\t\0:\2\n\0017\2\v\0:\2\f\0014\2\r\0\16\3\1\0>\2\2\4D\5\f€%\a\14\0\16\b\5\0$\a\b\a4\b\15\0007\b\16\b7\b\17\b\16\t\a\0003\n\18\0:\6\19\n:\a\20\n:\a\21\n>\b\3\1B\5\3\3N\5òG\0\1\0\nnumhl\vtexthl\ttext\1\0\0\16sign_define\afn\bvim\19DiagnosticSign\npairs\tInfo\tinfo\tHint\thint\tWarn\twarn\nError\1\0\0\nerror\tsign\vconfig\blsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd neorg ]]

-- Config for: neorg
try_loadstring("\27LJ\1\2Ý\2\0\0\6\0\20\0\0274\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\18\0003\2\3\0002\3\0\0:\3\4\0023\3\6\0003\4\5\0:\4\a\3:\3\b\0022\3\0\0:\3\t\0023\3\r\0003\4\v\0003\5\n\0:\5\f\4:\4\a\3:\3\14\0023\3\16\0003\4\15\0:\4\a\3:\3\17\2:\2\19\1>\0\2\1G\0\1\0\tload\1\0\0\25core.norg.completion\1\0\0\1\0\1\vengine\rnvim-cmp\21core.norg.dirman\1\0\0\15workspaces\1\0\0\1\0\1\17my_workspace\f~/neorg\24core.norg.concealer\18core.keybinds\vconfig\1\0\0\1\0\2\21default_keybinds\2\17neorg_leader\14<Leader>o\18core.defaults\1\0\0\nsetup\nneorg\frequire\0", "config", "neorg")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Goyo lua require("packer.load")({'goyo.vim'}, { cmd = "Goyo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Bdelete lua require("packer.load")({'vim-bbye'}, { cmd = "Bdelete", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Vista lua require("packer.load")({'vista.vim'}, { cmd = "Vista", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType http ++once lua require("packer.load")({'rest.nvim'}, { ft = "http" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType lisp ++once lua require("packer.load")({'slimv'}, { ft = "lisp" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/syuni/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]], true)
vim.cmd [[source /home/syuni/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]]
time([[Sourcing ftdetect script at: /home/syuni/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]], false)
time([[Sourcing ftdetect script at: /home/syuni/.local/share/nvim/site/pack/packer/opt/slimv/ftdetect/clojure.vim]], true)
vim.cmd [[source /home/syuni/.local/share/nvim/site/pack/packer/opt/slimv/ftdetect/clojure.vim]]
time([[Sourcing ftdetect script at: /home/syuni/.local/share/nvim/site/pack/packer/opt/slimv/ftdetect/clojure.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
