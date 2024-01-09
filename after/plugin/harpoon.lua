local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local harpoon_term = require("harpoon.term")

local utils = require("neoconfig.utils")

utils.n_keymap("<C-n>", function() harpoon_ui.nav_file(1) end, "Harpoon file 1")
utils.n_keymap("<C-m>", function() harpoon_ui.nav_file(2) end, "Harpoon file 2")
utils.n_keymap("<C-t>", function() harpoon_term.gotoTerminal(1) end, "Terminal")
utils.n_keymap("<leader>m", harpoon_mark.add_file, "Mark file")
utils.n_keymap("<leader>fm", function()
    harpoon_ui.toggle_quick_menu();
    vim.cmd.norm("$ze");
end, "Marked files")
