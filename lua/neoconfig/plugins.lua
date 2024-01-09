-- Install lazy.nvim if needed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    "folke/which-key.nvim",
    "mbbill/undotree",
    "folke/zen-mode.nvim",
    "karb94/neoscroll.nvim",
    "lewis6991/gitsigns.nvim",
    "numToStr/Comment.nvim",
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = "nvim-treesitter/nvim-treesitter-context"
    },
    -- LSP
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    "folke/neodev.nvim",
    {
        "mrcjkb/rustaceanvim",
        ft = "rust",
    },
    -- LSP END
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    {
        "theprimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
    },
    {
        "rest-nvim/rest.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        ft = "http",
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    },
    {
        "ruifm/gitlinker.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "BufRead",
    },
    {
        "ggandor/lightspeed.nvim",
        event = "BufRead",
    },
    {
        "linrongbin16/lsp-progress.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "linrongbin16/lsp-progress.nvim",
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = "tpope/vim-dadbod",
        cmd = "DBUIToggle",
    },
})
