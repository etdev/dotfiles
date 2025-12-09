-- Base thing for lazy
-- ~/.config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  -- TREESITTER (The Syntax Engine)
  --
  { import = "plugins" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      -- Run this when installing/updating the plugin
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      configs.setup({
        ensure_installed = {
          "ruby", "javascript", "go", "json", "html", "css",
          "scss", "vue", "markdown", "markdown_inline", "vim", "lua",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  -- New for nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = { theme = 'solarized_dark' }
      })
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup({
        toggler = {
          line = '<leader>c<space>',
        }
      })
    end,
  },

  -- Converted from vim-plug
  { "pbrisbin/vim-mkdir" },
  { "tpope/vim-endwise" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  -- { "vim-ruby/vim-ruby" },
  -- { "vim-scripts/matchit.zip" },
  { "scrooloose/nerdcommenter" },
  { "christoomey/vim-tmux-navigator" },
  -- { "vim-airline/vim-airline" },
  -- { "vim-airline/vim-airline-themes" },
  -- { "fatih/vim-go" },
  { "posva/vim-vue" },
  -- { "othree/html5.vim" },
  -- { "pangloss/vim-javascript" },
  { "honza/vim-snippets" },
  { "universal-ctags/ctags" },
  { "Chiel92/vim-autoformat" },
  -- { "rust-lang/rust.vim" },
  -- { "JulesWang/css.vim" },
  -- { "scrooloose/vim-slumlord" },
  -- { "aklt/plantuml-syntax" },
  -- {
  --   "junegunn/fzf",
  --   dir = "~/.fzf",
  --   build = "./install --all"
  -- },
  -- { "junegunn/fzf.vim" },
  { "jeetsukumaran/vim-indentwise" },
  -- { "uarun/vim-protobuf" },
  { "junegunn/goyo.vim" },

  -- Mac-specific
  {
    "shime/vim-livedown",
    cond = function()
      return vim.fn.has("mac") == 1
    end
  },

  -- Forked repos
  { "etdev/vim-hexcolor" },
  { "etdev/vim-textobject-pack" },
  { "etdev/ag.vim" },
  { "etdev/tslime.vim" },

  -- {
  --   'maxmx03/solarized.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   ---@type solarized.config
  --   opts = {},
  --   config = function(_, opts)
  --     vim.o.termguicolors = true
  --     vim.o.background = 'dark'
  --     require('solarized').setup(opts)
  --     vim.cmd.colorscheme 'solarized'
  --   end,
  -- },

  -- Solarized theme
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
        enabled = false,
        normal = false,
        normalfloat = false,
      },
      on_highlights = function(colors, color)
        local bg_main = '#0a0a0a'
        local bg_gutter = '#121212'

        return {
          -- 1. Main Background
          Normal = { bg = bg_main },
          NormalFloat = { bg = bg_main },
          NormalNC = { bg = bg_main },

          -- 2. The Gutter (Left Side)
          LineNr = { bg = bg_gutter },
          SignColumn = { bg = bg_gutter },
          CursorLineNr = { bg = bg_gutter },
          ColorColumn = { bg = bg_gutter },

          -- 3. Git Signs
          GitSignsAdd = { bg = bg_gutter, fg = colors.green },
          GitSignsChange = { bg = bg_gutter, fg = colors.yellow },
          GitSignsDelete = { bg = bg_gutter, fg = colors.red },

          -- 4. Diagnostics
          DiagnosticSignError = { bg = bg_gutter, fg = colors.red },
          DiagnosticSignWarn = { bg = bg_gutter, fg = colors.yellow },
          DiagnosticSignInfo = { bg = bg_gutter, fg = colors.blue },
          DiagnosticSignHint = { bg = bg_gutter, fg = colors.cyan },

          -- =======================================================
          -- 5. FIXES: Remove Ugly Blue Backgrounds
          -- =======================================================

          -- Fix: Parameters inside parentheses (data) => ...
          ['@variable.parameter'] = { bg = 'NONE' },
          ['@parameter'] = { bg = 'NONE' },
        }
      end
    },
    config = function(_, opts)
      -- 1. Standard Setup
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      require('solarized').setup(opts)
      vim.cmd.colorscheme 'solarized'

      -- 2. FORCE OVERRIDES
      vim.cmd [[
        " ---------------------------------------------------------
        " A. Background Fixes (Global)
        " ---------------------------------------------------------
        highlight! MatchParen guibg=NONE ctermbg=NONE gui=bold
        highlight! @variable.parameter guibg=NONE ctermbg=NONE
        highlight! @variable.parameter.javascript guibg=NONE ctermbg=NONE
        highlight! @parameter guibg=NONE ctermbg=NONE

        highlight! LspReferenceText guibg=NONE ctermbg=NONE gui=underline
        highlight! LspReferenceRead guibg=NONE ctermbg=NONE gui=underline
        highlight! LspReferenceWrite guibg=NONE ctermbg=NONE gui=underline

        " ---------------------------------------------------------
        " B. JS / Vue Custom Colors
        " ---------------------------------------------------------
        highlight! @tag.attribute.vue guifg=#585858
        highlight! @keyword.import.javascript guifg=#C86627
        highlight! @variable.javascript guifg=#808080
        " Also apply JS variable fix to TS just in case
        highlight! @variable.typescript guifg=#808080

        " ---------------------------------------------------------
        " C. Ruby Custom Colors (NEW)
        " ---------------------------------------------------------

        " 1. Ruby Variables -> Medium Grey #7F7F7F
        highlight! @variable.ruby guifg=#7F7F7F

        " 2. Ruby Constants & Types -> Gold/Brown #A0822A
        highlight! @constant.ruby guifg=#A0822A
        highlight! @type.ruby guifg=#A0822A

        " 3. Ruby Comments -> Dark Grey #4E4E4E
        highlight! @comment.ruby guifg=#4E4E4E
        highlight! @function.call.ruby guifg=#7F7F7F
        highlight! @keyword.return.ruby guifg=#688626
        highlight! @keyword.conditional.ruby guifg=#688626
        highlight! @variable.parameter.ruby guibg=NONE ctermbg=NONE

        highlight! @markup.strong guibg=NONE ctermbg=NONE guifg=#7F7F7F
        highlight! @constant.scss guibg=NONE ctermbg=NONE
        highlight! @string.scss guibg=NONE ctermbg=NONE
        highlight! @variable.parameter.scss guibg=NONE ctermbg=NONE
      ]]
    end,
  },
  -- Telescope (replaces fzf/ctrlp)
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
          mappings = {
            i = {
              ["<esc>"] = actions.close,  -- one press closes picker in insert mode
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
              ["<esc>"] = actions.close,  -- and in normal mode
            },
          },
        },
      })

      -- Enable fzf-native if you want it
      pcall(telescope.load_extension, "fzf")

      -- Ctrl+P for file finder (like ctrlp)
      vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>')
      vim.keymap.set('n', '<C-j>', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<C-k>', '<cmd>Telescope grep_string<cr>')

      -- Optional: other useful mappings
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
      vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>')
      vim.keymap.set('n', '<leader>fc', '<cmd>Telescope command_history<cr>')

      -- Your highlight tweak (kept as-is)
      local colors = vim.api.nvim_get_hl(0, { name = 'Normal' })
      if colors and colors.bg then
        vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = colors.bg })
      end
    end,
  },
  {
      "nvzone/typr",
      dependencies = "nvzone/volt",
      opts = {},
      cmd = { "Typr", "TyprStats" },
  },
})

-- Globally remove any strikethrough from all highlight groups
local function remove_all_strikethrough()
  local groups = vim.fn.getcompletion("", "highlight")
  for _, group in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok and hl.strikethrough then
      hl.strikethrough = false
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end
