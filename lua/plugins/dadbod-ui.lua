local utils = require("neoconfig.utils")

vim.g.db_ui_save_location = "~/.config/db_ui"

utils.n_keymap("<leader>D", "<cmd>DBUIToggle<cr>", "Database")
