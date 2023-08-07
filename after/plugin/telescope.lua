local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope.find_files) -- or git_files?
vim.keymap.set("n", "<leader>fg", telescope.live_grep)
vim.keymap.set("n", "<leader>fr", telescope.oldfiles)
vim.keymap.set("n", "<leader>fk", telescope.keymaps)
vim.keymap.set("n", "<leader>fH", telescope.help_tags)
vim.keymap.set("n", "<leader>fC", telescope.commands)
vim.keymap.set("n", "<leader>fR", telescope.registers)
vim.keymap.set("n", "<leader>fM", telescope.man_pages)
