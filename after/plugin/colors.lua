require("rose-pine").setup({
    variant = "main",
    disable_background = true,
})

vim.cmd("colorscheme rose-pine")

-- Style for highlight groups

local hl_style = { bg = "none" }
vim.api.nvim_set_hl(0, "Normal", hl_style)
vim.api.nvim_set_hl(0, "NormalFloat", hl_style)
vim.api.nvim_set_hl(0, "FloatBorder", hl_style)
vim.api.nvim_set_hl(0, "FloatTitle", hl_style)
