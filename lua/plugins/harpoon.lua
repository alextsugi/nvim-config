local harpoon = require("harpoon")

local utils = require("neoconfig.utils")

local function current_branch()
    local branch = vim.fn.system("git symbolic-ref --short HEAD 2> /dev/null | tr -d '\n'")
    if branch == "" then
        return nil
    end

    return branch
end

local mark_branch = true

local function select(within_branch, idx)
    return function()
        mark_branch = within_branch
        harpoon:list():select(idx)
    end
end

local function mark(within_branch)
    return function()
        mark_branch = within_branch
        harpoon:list():add()
        harpoon:sync()
    end
end

vim.g.harpoon_log_level = "warn"
harpoon:setup({
    settings = {
        save_on_toggle = true,
        key = function()
            if mark_branch then
                local branch = current_branch()
                if branch then
                    return (vim.uv.cwd() or "") .. "-" .. branch
                end
            end

            return vim.uv.cwd() or ""
        end
    },
})

-- Actions
utils.n_keymap("<leader>m", mark(true), "Mark file")
utils.n_keymap("<leader>w", mark(false), "Mark file in workspace")

utils.n_keymap("<leader>fm", function()
    mark_branch = true
    harpoon.ui:toggle_quick_menu(harpoon:list())
    vim.cmd.norm("$ze")
end, "Harpoon files")

utils.n_keymap("<leader>fw", function()
    mark_branch = false
    harpoon.ui:toggle_quick_menu(harpoon:list())
    vim.cmd.norm("$ze")
end, "Harpoon files")

-- Default list navigation
utils.n_keymap("<C-n>", select(true, 1), "Harpoon file 1")
utils.n_keymap("<C-m>", select(true, 2), "Harpoon file 2")
utils.n_keymap("<C-,>", select(true, 3), "Harpoon file 3")
utils.n_keymap("<C-.>", select(true, 4), "Harpoon file 4")

-- Terminal

---@type HarpoonList
local term_list = harpoon:list("terms")

local function create_terminal()
    vim.cmd("terminal")
    local buf_id = vim.api.nvim_get_current_buf()
    return vim.api.nvim_buf_get_name(buf_id)
end

local function select_term(index)
    mark_branch = false
    if index > term_list:length() then
        create_terminal()
        term_list:add()
    else
        term_list:select(index)
    end
end

local function remove_closed_terms()
    mark_branch = false
    for _, term in ipairs(term_list.items) do
        local bufnr = vim.fn.bufnr(term.value)
        if bufnr == -1 then
            term_list:remove(term)
        end
    end
end

vim.api.nvim_create_autocmd({ "TermClose", "VimEnter" }, {
    pattern = "*",
    callback = remove_closed_terms,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufUnload" }, {
    pattern = "term://*",
    callback = remove_closed_terms,
})

utils.n_keymap("<C-t>", function() select_term(1) end, "Terminal 1")
utils.n_keymap("<C-g>", function() select_term(1) end, "Terminal 1")

utils.n_keymap("<leader>ft", function()
    mark_branch = false
    harpoon.ui:toggle_quick_menu(term_list)
end, "Terminals")
