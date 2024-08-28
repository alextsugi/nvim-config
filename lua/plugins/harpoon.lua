local harpoon = require("harpoon")

local utils = require("neoconfig.utils")

local function current_branch()
    local branch = vim.fn.system("git symbolic-ref --short HEAD 2> /dev/null | tr -d '\n'")
    if branch == "" then
        return nil
    end

    return branch
end

vim.g.harpoon_log_level = "warn"
harpoon:setup({
    settings = {
        save_on_toggle = true,
        key = function()
            local branch = current_branch()
            if branch then
                return (vim.uv.cwd() or "") .. "-" .. branch
            end

            return vim.uv.cwd() or ""
        end
    },
})

-- Actions
utils.n_keymap("<leader>m", function() harpoon:list():add() end, "Mark file")

utils.n_keymap("<leader>fm", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
    vim.cmd.norm("$ze")
end, "Harpoon files")

-- Default list navigation
utils.n_keymap("<C-n>", function() harpoon:list():select(1) end, "Harpoon file 1")
utils.n_keymap("<C-m>", function() harpoon:list():select(2) end, "Harpoon file 2")
utils.n_keymap("<C-,>", function() harpoon:list():select(3) end, "Harpoon file 3")
utils.n_keymap("<C-.>", function() harpoon:list():select(4) end, "Harpoon file 4")
