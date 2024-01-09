local M = {}

local default_opts = {
    silent = true,
    noremap = true,
}

local function with_default_opts(opts, desc)
    opts = vim.tbl_extend("force", default_opts, opts or {})
    opts.desc = desc or opts.desc
    return opts
end

-- Binds a key
function M.keymap(mode, key, cmd, desc, opts)
    opts = with_default_opts(opts, desc)
    vim.keymap.set(mode, key, cmd, opts)
end

-- Binds multiple keys
function M.keymaps(opts, mappings)
    opts = with_default_opts(opts, nil)
    for mode, mode_mappings in pairs(mappings) do
        for key, map_opts in pairs(mode_mappings) do
            M.keymap(mode, key, map_opts[1], map_opts[2], opts)
        end
    end
end

-- Binds a normal mode key
function M.n_keymap(key, cmd, desc, opts)
    M.keymap("n", key, cmd, desc, opts)
end

-- Binds a visual mode key
function M.v_keymap(key, cmd, desc, opts)
    M.keymap("v", key, cmd, desc, opts)
end

-- Binds an insert mode key
function M.i_keymap(key, cmd, desc, opts)
    M.keymap("i", key, cmd, desc, opts)
end

-- Binds a terminal mode key
function M.t_keymap(key, cmd, desc, opts)
    M.keymap("t", key, cmd, desc, opts)
end

return M
