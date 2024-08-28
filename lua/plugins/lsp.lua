local utils = require("neoconfig.utils")
local lsp = require('lspconfig')

local ensure_installed = {
    "rust_analyzer",
    "gopls",
    "lua_ls",
}

----------------------------------------
-- Neodev (for plugin development)
----------------------------------------
-- NOTE: make sure to setup neodev BEFORE lspconfig

require("neodev").setup({
    library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = false, -- configures jsonls to provide completion for project specific .luarc.json files
    -- With lspconfig, Neodev will automatically setup your lua-language-server
    lspconfig = true,
    -- much faster, but needs lua-language-server >= 3.6.0
    pathStrict = true,
})

----------------------------------------
-- LSP
----------------------------------------

-- Default server key mappings
local telescope = require("telescope.builtin")
local default_server_mappings = {
    n = {
        gd = { telescope.lsp_definitions, "Definition" },
        gi = { telescope.lsp_implementations, "Implementations" },
        gr = { telescope.lsp_references, "References" },
        K = { vim.lsp.buf.hover, "Hover" },
        ["<leader>a"] = { vim.lsp.buf.code_action, "Actions" },
        ["<leader>lr"] = { vim.lsp.buf.rename, "Rename" },
        ["<leader>lf"] = { vim.lsp.buf.format, "Format buffer" },
        ["<leader>ls"] = { telescope.lsp_document_symbols, "Symbols of buffer" },
        ["<leader>lS"] = { telescope.lsp_dynamic_workspace_symbols, "Symbols of workspace" },
    },
    i = {
        ["<C-h>"] = { vim.lsp.buf.signature_help, "Signature help" },
    },
}

local function rs_binding(action)
    return function()
        vim.cmd.RustLsp(action)
    end
end

-- Per-server key mappings overrides
local server_mappings = {
    ["rust-analyzer"] = {
        n = {
            ["<leader>r"] = { rs_binding("runnables"), "Runnables" },
            ["<leader>lm"] = { rs_binding("expandMacro"), "Macro expand" },
            ["<leader>le"] = { rs_binding("explainError"), "Explain error" },
            ["<leader>da"] = { rs_binding("debuggables"), "Debuggables" },
            ["<leader>lP"] = { rs_binding("parentModule"), "Parent module" },
            ["<leader>lR"] = { rs_binding("reloadWorkspace"), "Reload workspace" },
            ["<leader>lC"] = { rs_binding("openCargo"), "Cargo" },
        },
    }
}

-- LSP on attach hook that sets key mappings
vim.api.nvim_create_autocmd('LspAttach', {
    desc = "LSP actions",
    callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local overrides = server_mappings[client.name] or {}
        local mappings = vim.tbl_deep_extend("force", default_server_mappings, overrides)
        utils.keymaps({ buffer = bufnr }, mappings)
    end
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Default setup function for LSP server, i.e., `lsp[server].setup()`
local function default_setup(server)
    lsp[server].setup({
        capabilities = lsp_capabilities,
    })
end

-- Setup servers
require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
    handlers = {
        default_setup,

        -- TODO: Figure out what's wrong with rustaceanvim
        -- rust_analyzer = function()
        --     -- Delegate to rustaceanvim
        -- end,

        lua_ls = function()
            lsp.lua_ls.setup({
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            })
        end,
    },
})

----------------------------------------
-- Autocompletion
----------------------------------------

require("luasnip.loaders.from_vscode").lazy_load()

-- Setup autocomplition
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Insert }
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
    }),
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

----------------------------------------
-- LSP initializing progress
----------------------------------------

require("lsp-progress").setup({
    debug = false,
    console_log = true,
    file_log = false,
    client_format = function(client_name, spinner, series_messages)
        return #series_messages > 0
            and (spinner .. " " .. table.concat(
                series_messages,
                ", "
            ))
            or nil
    end,
    format = function(client_messages)
        local active_clients = vim.lsp.get_active_clients()
        if #client_messages > 0 then
            return table.concat(client_messages, " ")
        end
        if #active_clients == 0 then
            return nil
        end

        local client_names = {}
        for _, client in ipairs(active_clients) do
            if client and client.name ~= "" then
                table.insert(client_names, client.name)
            end
        end
        return table.concat(client_names, "|")
    end,
})
