require("lualine").setup({
    options = {
        theme = "rose-pine",
    },
    sections = {
        lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = { "branch" },
        lualine_c = { "require('lsp-progress').progress()" },
        lualine_x = {
            {
                'diagnostics',

                -- Displays diagnostics for the defined severity types
                sections = { "error", "warn" },
                symbols = { error = 'E', warn = 'W' },
                colored = true, -- Displays diagnostics status in color if set to true.
                update_in_insert = false, -- Update diagnostics in insert mode.
                always_visible = false, -- Show diagnostics even if there are none.
            },
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})

-- Refresh on progress
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
    pattern = "LspProgressStatusUpdated",
    group = "lualine_augroup",
    callback = require("lualine").refresh,
})
