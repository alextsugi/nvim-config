local zen_mode = require("zen-mode")

zen_mode.setup({
    window = {
        width = 90,
        options = {},
    },
})

vim.keymap.set("n", "<leader>z", zen_mode.toggle)
