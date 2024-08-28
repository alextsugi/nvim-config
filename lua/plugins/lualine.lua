require("lualine").setup({
    options = {
        theme = "rose-pine",
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { "mode",   fmt = function(str) return str:sub(1, 1) end },
            { "branch", icons_enabled = false },
        },
        lualine_b = {
            {
                "filename",
                path = 1,
                file_status = true,
                symbols = {
                    modified = '~',
                    readonly = '-',
                    unnamed = '',
                    newfile = '(new)',
                },
            },
        },
        lualine_c = {
            {
                'diff',
                colored = true,                                           -- Displays a colored diff status if set to true
                symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
            },
        },
        lualine_x = {
            {
                "diagnostics",
                sections = { "error", "warn" },
                symbols = { error = 'E', warn = 'W' },
                colored = true,
                update_in_insert = false,
                always_visible = false,
            },
        },
        lualine_y = {
            "require('lsp-progress').progress()",
            {
                "filetype",
                cond = function()
                    local progress = require('lsp-progress').progress()
                    return progress == nil or progress == ""
                end,
            },
        },
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
