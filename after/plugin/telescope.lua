local utils = require("neoconfig.utils")

require("telescope").setup({
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "-uu", "--files", "--glob", "!**/.git/*" },
    },
  },
})

local telescope = require("telescope.builtin")
utils.n_keymap("<leader>ff", telescope.find_files, "Files") -- or git_files?
utils.n_keymap("<leader>fg", telescope.live_grep, "Grep")
utils.n_keymap("<leader>fr", telescope.oldfiles, "Recent files")
utils.n_keymap("<leader>fk", telescope.keymaps, "Keymaps")
utils.n_keymap("<leader>fH", telescope.help_tags, "Help")
utils.n_keymap("<leader>fC", telescope.commands, "Commands")
utils.n_keymap("<leader>fR", telescope.registers, "Registers")
utils.n_keymap("<leader>fM", telescope.man_pages, "Man pages")
utils.n_keymap("<leader>fb", telescope.buffers, "Buffers")
utils.n_keymap("<leader>lD", telescope.diagnostics, "Diagnostics project")
utils.n_keymap("<leader>ld", function() telescope.diagnostics({ bufnr = 0 }) end, "Diagnostics buffer")
