vim.g.mapleader = ","

vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>")
vim.keymap.set("n", "<leader>n", "<cmd>ene!<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>nohlsearch<cr>")

-- Split
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>split<cr>")

-- Buffers
-- vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>")
-- vim.keymap.set("n", "<C-h>", "<cmd>bprev<cr>")
vim.keymap.set("n", "<leader>b]", "<cmd>vertical resize +5<cr>")
vim.keymap.set("n", "<leader>b[", "<cmd>vertical resize -5<cr>")

-- Better window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Terminal mappings
vim.api.nvim_set_keymap('t', '<ESC>', [[<C-\><C-n>]], { noremap = true })
