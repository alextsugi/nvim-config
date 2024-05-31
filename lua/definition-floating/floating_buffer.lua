local M = {}

local utils = require("neoconfig.utils")

local function find_window_by_var(name, value)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.F.npcall(vim.api.nvim_win_get_var, win, name) == value then
            return win
        end
    end
end

local function close_preview_window(winnr, bufnrs)
    vim.schedule(function()
        -- exit if we are in one of ignored buffers
        if bufnrs and vim.tbl_contains(bufnrs, vim.api.nvim_get_current_buf()) then
            return
        end

        local augroup = 'preview_window_' .. winnr
        pcall(vim.api.nvim_del_augroup_by_name, augroup)
        pcall(vim.api.nvim_win_close, winnr, true)
    end)
end

local function close_preview_autocmd(events, winnr, bufnrs)
    local augroup = vim.api.nvim_create_augroup('preview_window_' .. winnr, {
            clear = true,
        })

    -- close the preview window when entered a buffer that is not
    -- the floating window buffer or the buffer that spawned it
    vim.api.nvim_create_autocmd('BufEnter', {
        group = augroup,
        callback = function()
            close_preview_window(winnr, bufnrs)
        end,
    })

    if #events > 0 then
        vim.api.nvim_create_autocmd(events, {
            group = augroup,
            buffer = bufnrs[2],
            callback = function()
                close_preview_window(winnr)
            end,
        })
    end
end

function M.open_floating_preview(bufnr, opts)
    opts = opts or {}
    opts.wrap = opts.wrap ~= false
    opts.focus = opts.focus ~= false
    opts.close_events = opts.close_events or { 'CursorMoved', 'CursorMovedI', 'InsertCharPre' }

    local current_bufnr = vim.api.nvim_get_current_buf()

    if opts.focus_id and opts.focusable ~= false and opts.focus then
        local current_winnr = vim.api.nvim_get_current_win()
        if vim.F.npcall(vim.api.nvim_win_get_var, current_winnr, opts.focus_id) then
            vim.api.nvim_command('wincmd p')
            return bufnr, current_winnr
        end
        do
            local win = find_window_by_var(opts.focus_id, bufnr)
            if win and vim.api.nvim_win_is_valid(win) and vim.fn.pumvisible() == 0 then
                print("window found: ", win)
                -- focus and return the existing buf, win
                vim.api.nvim_set_current_win(win)
                -- vim.fn.win_gotoid(win)
                vim.api.nvim_command('stopinsert')
                return bufnr, win
            end
        end
    end

    local existing_float = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, 'lsp_floating_preview')
    if existing_float and vim.api.nvim_win_is_valid(existing_float) then
        vim.api.nvim_win_close(existing_float, true)
    end

    if opts.wrap then
        opts.wrap_at = opts.wrap_at or vim.api.nvim_win_get_width(0)
    else
        opts.wrap_at = nil
    end

    local win_opts = vim.lsp.util.make_floating_popup_options(opts.width, opts.height, opts)
    local floating_winnr = vim.api.nvim_open_win(bufnr, false, win_opts)
    print("window opened: ", floating_winnr)

    vim.api.nvim_win_set_option(floating_winnr, 'foldenable', false)
    vim.api.nvim_win_set_option(floating_winnr, 'wrap', opts.wrap)

    if opts.modifiable then
        vim.api.nvim_buf_set_option(bufnr, 'modifiable', true)
        vim.api.nvim_buf_set_option(bufnr, "buftype", "")
    end
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
    utils.n_keymap("q", function() vim.api.nvim_win_close(floating_winnr, true) end, "Quit",
        { silent = true, noremap = true, nowait = true })
    -- TODO: Add autocmd that closes window when we change buffer and removes hightlights
    -- close_preview_autocmd(opts.close_events, floating_winnr, { bufnr, current_bufnr })

    if opts.focus_id then
        vim.api.nvim_win_set_var(floating_winnr, opts.focus_id, bufnr)
    end
    vim.api.nvim_buf_set_var(bufnr, 'lsp_floating_preview', floating_winnr)

    return bufnr, floating_winnr
end

return M
