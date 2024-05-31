local zen_mode = require("zen-mode")
local utils = require("neoconfig.utils")

zen_mode.setup({
    window = {
        width = 90,
        options = {},
    },
})

utils.n_keymap("<leader>z", zen_mode.toggle, "Zen mode")
