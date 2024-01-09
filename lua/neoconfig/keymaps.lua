local utils = require("neoconfig.utils")

vim.g.mapleader = ","

utils.n_keymap("<leader>q", "<cmd>bd<cr>", "Close buffer")
utils.n_keymap("<leader>n", "<cmd>ene!<cr>", "New file")
utils.n_keymap("<leader>c", "<cmd>nohlsearch<cr>", "Clear highlighting")

-- Split
utils.n_keymap("<leader>v", "<cmd>vsplit<cr>", "Vertical split")
utils.n_keymap("<leader>h", "<cmd>split<cr>", "Horizontal split")

-- Buffers
-- utils.n_keymap("<C-l>", "<cmd>bnext<cr>", "Next buffer")
-- utils.n_keymap("<C-h>", "<cmd>bprev<cr>", "Prev buffer")
utils.n_keymap("<leader>b]", "<cmd>vertical resize +5<cr>", "Vertica resize")
utils.n_keymap("<leader>b[", "<cmd>vertical resize -5<cr>", "Horizontal resize")

-- Better window movement
utils.n_keymap("<C-h>", "<C-w>h", "Left window")
utils.n_keymap("<C-j>", "<C-w>j", "Bottom window")
utils.n_keymap("<C-k>", "<C-w>k", "Top window")
utils.n_keymap("<C-l>", "<C-w>l", "Right window")

-- Terminal mappings
utils.t_keymap("<ESC>", [[<C-\><C-n>]], "Quit terminal", { noremap = true })

-- Diagnostics
utils.n_keymap("<leader>ln", vim.diagnostic.goto_next, "Next diagnostic", { noremap = true })
utils.n_keymap("<leader>lp", vim.diagnostic.goto_prev, "Prev diagnostic", { noremap = true })

-- Netrw  mappings
utils.n_keymap("<leader>e", "<cmd>Ex<cr>", "Explorer")
local netrw_mappings_group = vim.api.nvim_create_augroup("NetrwMappings", {})
vim.api.nvim_create_autocmd("filetype", {
    group = netrw_mappings_group,
    pattern = "netrw",
    desc = "Mappings for netrw",
    callback = function()
        local opts = { noremap = true, buffer = true }
        utils.n_keymap("v", "<cmd>normal! v<cr>", "Visual mode", opts)
    end,
})
