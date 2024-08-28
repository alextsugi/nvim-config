require("rose-pine").setup({
    variant = "main",
    disable_background = true,
    disable_float_background = true,
    highlight_groups = {
        FloatTitle = { bg = "none" },
        FloatBorder = { bg = "none" },
        NormalFloat = { bg = "none" },
        TelescopeBorder = { fg = "highlight_high", bg = "none" },
        TelescopeNormal = { bg = "none" },
        TelescopePromptNormal = { bg = "base" },
        TelescopeResultsNormal = { fg = "subtle", bg = "none" },
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        GitSignsAdd = { bg = "none" },
        GitSignsChange = { bg = "none" },
        GitSignsDelete = { bg = "none" },
    },
})

vim.cmd("colorscheme rose-pine")

local border_style = "rounded"

vim.diagnostic.config({
    float = { border = border_style },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
        border = border_style
    })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
        border = border_style
    })
