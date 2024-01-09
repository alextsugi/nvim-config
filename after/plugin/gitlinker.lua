local gitlinker = require("gitlinker")
local gitlinker_actions = require("gitlinker.actions")
local gitlinker_hosts = require("gitlinker.hosts")

local utils = require("neoconfig.utils")

local cfg = {
    opts = {
        remote = nil, -- force the use of a specific remote
        -- adds current line nr in the url for normal mode
        add_current_line_on_normal_mode = true,
        -- callback for what to do with the url
        action_callback = gitlinker_actions.copy_to_clipboard,
        -- print the url after performing the action
        print_url = true,
    },
    callbacks = {
        ["github.com"] = gitlinker_hosts.get_github_type_url,
        ["gitlab.com"] = gitlinker_hosts.get_gitlab_type_url,
        ["try.gitea.io"] = gitlinker_hosts.get_gitea_type_url,
        ["codeberg.org"] = gitlinker_hosts.get_gitea_type_url,
        ["bitbucket.org"] = gitlinker_hosts.get_bitbucket_type_url,
        ["try.gogs.io"] = gitlinker_hosts.get_gogs_type_url,
        ["git.sr.ht"] = gitlinker_hosts.get_srht_type_url,
        ["git.launchpad.net"] = gitlinker_hosts.get_launchpad_type_url,
        ["repo.or.cz"] = gitlinker_hosts.get_repoorcz_type_url,
        ["git.kernel.org"] = gitlinker_hosts.get_cgit_type_url,
        ["git.savannah.gnu.org"] = gitlinker_hosts.get_cgit_type_url,
    },
    -- Use custom mappings
    mappings = nil,
}

local ok, nl = pcall(require, "neoconfig-local")
if ok then
    nl.configure_gitlinker(cfg)
end

gitlinker.setup(cfg)

utils.n_keymap("<leader>gy", function() gitlinker.get_buf_range_url("n") end, "Yank url")
utils.v_keymap("<leader>gy", function() gitlinker.get_buf_range_url("v") end, "Yank url for selected")
