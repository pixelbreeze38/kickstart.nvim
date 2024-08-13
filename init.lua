-- General Settings
vim.g.mapleader = ' ' -- Set leader key to space
vim.g.maplocalleader = ' ' -- Set local leader key to space
vim.g.have_nerd_font = true -- Enable Nerd Font support

-- UI Settings
vim.opt.number = true -- Show line numbers
vim.opt.mouse = 'a' -- Enable mouse support in all modes
vim.opt.showmode = false -- Don't show mode in command line (status line will show it)
vim.wo.relativenumber = true -- Show relative line numbers
vim.wo.number = true -- Show absolute line number on current line
vim.opt.cursorline = true -- Highlight the current line
vim.opt.signcolumn = 'yes' -- Always show the sign column
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = { -- Define how invisible characters are displayed
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

-- Editor Behavior
vim.opt.breakindent = true -- Maintain indent when wrapping lines
vim.opt.undofile = true -- Persistent undo history
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if search pattern contains uppercase
vim.opt.updatetime = 250 -- Faster completion and other features
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.inccommand = 'split' -- Show effects of substitute command in real-time
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor when scrolling

-- Indentation Settings
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindent
vim.opt.expandtab = true -- Use spaces instead of tabs

-- Clipboard Settings (scheduled to avoid startup errors)
-- vim.schedule(function()
--   vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
-- end)

-- File Type Specific Settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function()
    vim.bo.tabstop = 2 -- Use 2 spaces for tabs in Lua files
    vim.bo.shiftwidth = 2 -- Use 2 spaces for autoindent in Lua files
    vim.bo.expandtab = true -- Use spaces instead of tabs in Lua files
  end,
})

-- Netrw Settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    vim.opt_local.number = true -- Show line numbers in Netrw
    vim.opt_local.relativenumber = true -- Show relative line numbers in Netrw
  end,
})

-- General Custom Keymaps
vim.keymap.set('n', '<leader>b', ':edit %:h<CR>', { desc = 'Go back to file explorer', noremap = true, silent = true })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlighting with Esc' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window Navigation Keymaps
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank() -- Briefly highlight yanked text
  end,
})

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim Setup
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  -- Clone lazy.nvim if it doesn't exist
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath) -- Add lazy.nvim to runtime path

-- Plugin Configuration
require('lazy').setup({

  -- Cool Pluging
  require 'kickstart.plugins.vim-sleuth', -- Automatically adjusts 'shiftwidth' and 'expandtab' based on file contents
  require 'kickstart.plugins.gitsigns', -- Adds git-related signs to the gutter and utilities for managing changes
  require 'kickstart.plugins.which-key', -- Displays a popup with possible key bindings
  require 'kickstart.plugins.telescope', -- Fuzzy finder for files, buffers, and more
  require 'kickstart.plugins.neo-tree', -- File explorer plugin
  require 'kickstart.plugins.harpoon', -- Quick file navigation and switching
  require 'kickstart.plugins.undotree', -- Undo tree

  -- Custom git_popup plugin
  require 'custom.plugins.git_popup',

  -- LSP Plugins
  require 'kickstart.plugins.lazydev', -- Configures Lua LSP for Neovim config and plugins
  require 'kickstart.plugins.luvit-meta', -- Provides type definitions for the Lua platform Luvit
  require 'kickstart.plugins.nvim-lspconfig', -- Main LSP configuration plugin
  require 'kickstart.plugins.conform', -- Autoformatting plugin
  require 'kickstart.plugins.nvim-cmp', -- Autocompletion plugin
  require 'kickstart.plugins.todo-comments', -- Highlights TODO, FIXME, etc. in comments
  require 'kickstart.plugins.mini', -- Collection of small independent plugins/modules
  require 'kickstart.plugins.nvim-treesitter', -- Provides better syntax highlighting and code navigation

  -- Commented out plugins (can be enabled if needed)
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',

  -- Default colorscheme
  require 'kickstart.colorscheme.tokyonight', -- Tokyo Night color scheme
}, {
  ui = {
    -- Configure icons based on whether Nerd Font is available
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
