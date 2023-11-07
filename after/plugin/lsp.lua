local lsp = require("lsp-zero")
lsp.nvim_workspace()

lsp.preset("recommended")

lsp.ensure_installed({
    "rust_analyzer",
    "gopls",
    "lua_ls",
})

local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Insert }

local cmp_mappings = lsp.defaults.cmp_mappings({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp_action.luasnip_supertab(),
    })

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    select_behavior = cmp.SelectBehavior.Insert,
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local telescope = require("telescope.builtin")

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
  vim.keymap.set("n", "gr", telescope.lsp_references, opts)

  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
  vim.keymap.set("n", "<leader>ls", telescope.lsp_document_symbols, opts)
  vim.keymap.set("n", "<leader>lS", telescope.lsp_workspace_symbols, opts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
