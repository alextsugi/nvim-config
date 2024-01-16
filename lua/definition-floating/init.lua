local M = {}

local utils = require("neoconfig.utils")

local default_config = {
    -- Highlight group for definition highlighting.
    -- Set to nil to disable highlighting.
    highlight_group = "Visual",
    floating_preview = {
        border = "rounded",
        height = nil,
        width = nil,
        max_height = 20,
        max_width = 60,
        focusable = true,
        -- Enables wrapping long lines
        wrap = false,
        -- Number of lines to pad contents at top
        pad_top = nil,
        -- Number of lines to pad contents at bottom
        pad_bottom = nil,
    },
    -- Use empty nil to disable a mapping
    mappings = {
        show_float = "<leader>lK",
        vertical_split = "<leader>v",
        horizontal_split = "<leader>h",
    },
}

local preview_options = { focus_id = "definition_float" }

local config = {
    private = {
        preview_options = preview_options,
    },
}

function M.setup(cfg)
    cfg = vim.tbl_deep_extend("force", default_config, cfg or {})
    if cfg.floating_preview == nil then
        cfg.floating_preview = default_config.floating_preview
    end
    cfg.private = {}

    config = cfg
    config.private.preview_options = vim.tbl_extend("force", cfg.floating_preview, preview_options)

    if cfg.mappings ~= nil and cfg.mappings.show_float ~= nil then
        utils.n_keymap(cfg.mappings.show_float, M.definition_float, "Definition float")
    end
end

local function show_float(location)
    if location.filename == nil then
        return
    end

    local filetype = vim.filetype.match({ filename = location.filename })

    local bufnr = vim.fn.bufadd(location.filename)
    if not vim.api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
    end

    local contents = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    local syntax = vim.api.nvim_buf_get_option(bufnr, "syntax")
    if syntax == "" then
        syntax = vim.api.nvim_buf_get_option(bufnr, "filetype")
    end
    local float_bufnr, float_winnr = vim.lsp.util.open_floating_preview(
            contents, syntax, config.private.preview_options)

    vim.api.nvim_buf_set_option(float_bufnr, "filetype", filetype)
    -- TODO: Add mutability
    -- if config.private.preview_options.modifiable then
    --     vim.api.nvim_buf_set_option(float_bufnr, "modifiable", true)
    --     vim.api.nvim_buf_set_option(float_bufnr, "buftype", "")
    -- end

    if config.highlight_group ~= nil then
        local ns = vim.api.nvim_create_namespace("definition_float")
        vim.highlight.range(
            float_bufnr, ns, config.highlight_group,
            { location.lnum - 1, 0 }, { location.lnum - 1, -1 })
    end

    --- Jump to the location
    vim.api.nvim_win_set_cursor(float_winnr, { location.lnum + 1, 0 })

    -- Mappings
    if config.mappings ~= nil then
        local map_opts = { noremap = true, buffer = float_bufnr }

        if config.mappings.vertical_split ~= nil then
            utils.n_keymap(
                "<leader>v",
                function()
                    vim.cmd("vsplit " .. location.filename)
                end,
                "Vertical split",
                map_opts
            )
        end

        if config.mappings.horizontal_split ~= nil then
            utils.n_keymap(
                "<leader>h",
                function()
                    vim.cmd("split " .. location.filename)
                end,
                "Horizontal split",
                map_opts
            )
        end
    end
end

local function definition_handler(err, result, ctx)
    if err then
        vim.api.nvim_err_writeln("Error when finding definition: " .. err.message)
        return
    end

    local locations = {}
    if result then
        local items = vim.lsp.util.locations_to_items(result, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
        locations = vim.F.if_nil(items, {})
    end
    if vim.tbl_isempty(locations) then
        return
    end

    -- Do we need to support multiple definitions?
    show_float(locations[1])
end

function M.definition_float()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, "textDocument/definition", params, definition_handler)
end

return M
