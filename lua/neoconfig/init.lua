-- `keymaps` should be the first require
require("neoconfig.keymaps")
-- Plugins
require("neoconfig.plugins")

-- Vim options
vim.opt.clipboard      = "unnamedplus" -- use system clipboard
vim.opt.completeopt    = { "menuone", "noselect" }
-- vim.opt.fileencoding = "utf-8"             -- the encoding written to a file
vim.opt.foldexpr       = "nvim_treesitter#foldexpr()"
vim.opt.hidden         = true -- to keep multiple buffers open
vim.opt.hlsearch       = true -- highlight all matches
vim.opt.ignorecase     = true -- ignore case in search patterns
vim.opt.smartcase      = true -- override the 'ignorecase' option if the search pattern contains upper case characters
vim.opt.mouse          = "" -- disable mouse
vim.opt.pumheight      = 10 -- pop up menu height
vim.opt.showmode       = true -- show the active mode
vim.opt.showtabline    = 0 -- hide tabs
vim.opt.breakindent    = true
vim.opt.smartindent    = true -- autoindenting when starting a new line
vim.opt.splitbelow     = true -- force all horizontal splits to go below current window
vim.opt.splitright     = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile       = false -- creates a swapfile
vim.opt.termguicolors  = true
vim.opt.title          = true -- set the title of window to the value of the titlestring
vim.opt.titlestring    = "%<%F%=%l/%L"
vim.opt.updatetime     = 300 -- faster completion
vim.opt.expandtab      = false -- convert tabs to spaces
vim.opt.shiftwidth     = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop        = 2 -- insert 2 spaces for a tab
vim.opt.cursorline     = false -- don't highlight the current line
vim.opt.number         = true -- show line numbers
vim.opt.numberwidth    = 2
vim.opt.relativenumber = true -- use relative line numbers
vim.wo.wrap            = false -- display long lines as-is
vim.wo.linebreak       = false
vim.wo.list            = false
vim.opt.spell          = false -- it distracts
vim.opt.spelllang      = "en"
vim.opt.scrolloff      = 8
vim.opt.sidescrolloff  = 8
vim.opt.list           = true
vim.opt.listchars      = "tab:» ,nbsp:·,trail:~" -- configure whitespace simbols
vim.opt.backup         = false
vim.opt.writebackup    = false
vim.opt.undodir        = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile       = true -- enable persistent undo
-- vim.opt.signcolumn = "yes"                 -- always show the sign column
