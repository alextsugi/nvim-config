local gitlinker = require("gitlinker")
local actions = require("gitlinker.actions")
local hosts = require("gitlinker.hosts")

local utils = require("neoconfig.utils")

local cfg = {
    opts = {
        remote = nil, -- force the use of a specific remote
        add_current_line_on_normal_mode = true,
        action_callback = actions.copy_to_clipboard,
        print_url = true,
    },
    callbacks = {
        ["github.com"] = hosts.get_github_type_url,
        ["gitlab.com"] = hosts.get_gitlab_type_url,
        ["try.gitea.io"] = hosts.get_gitea_type_url,
        ["codeberg.org"] = hosts.get_gitea_type_url,
        ["bitbucket.org"] = hosts.get_bitbucket_type_url,
        ["try.gogs.io"] = hosts.get_gogs_type_url,
        ["git.sr.ht"] = hosts.get_srht_type_url,
        ["git.launchpad.net"] = hosts.get_launchpad_type_url,
        ["repo.or.cz"] = hosts.get_repoorcz_type_url,
        ["git.kernel.org"] = hosts.get_cgit_type_url,
        ["git.savannah.gnu.org"] = hosts.get_cgit_type_url
    },
}

local ok, nl = pcall(require, "neoconfig-local")
if ok then
    nl.configure_gitlinker(cfg)
end

gitlinker.setup(cfg)

utils.n_keymap("<leader>gy", function() gitlinker.get_buf_range_url("n") end, "Yank url")
utils.v_keymap("<leader>gy", function() gitlinker.get_buf_range_url("v") end, "Yank url for selected")
