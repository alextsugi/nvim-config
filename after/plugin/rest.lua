-- Environment file selector
local telescope = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local config = require("rest-nvim.config")

local function select_rest_environment()
    telescope.find_files({
        hidden = true,
        no_ignore = true,
        search_file = ".env*",
        attach_mappings = function(bufnr, _)
            actions.select_default:replace(function()
                actions.close(bufnr)

                local selection = action_state.get_selected_entry()
                local path = selection[1]
                config.set({ env_file = path })
                vim.print("HTTP environment set to " .. path)
            end)

            return true
        end,
    })

    -- or using vim.ui.select
    -- vim.ui.select(
    --     { ".env_local", ".env_dev", ".env_prod" },
    --     {
    --         prompt = "Select HTTP envronment file",
    --     },
    --     function(choise)
    --       config.set({ env_file = choise })
    --       vim.print("HTTP environment set to "..path)
    --     end
    -- )
end
-- End environment file selector

vim.keymap.set("n", "<leader>tt", function() require("rest-nvim").run() end)
vim.keymap.set("n", "<leader>te", select_rest_environment)
