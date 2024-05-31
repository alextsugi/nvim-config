local gitlinker = require("gitlinker")

local utils = require("neoconfig.utils")

-- local ok, nl = pcall(require, "neoconfig-local")
-- if ok then
--     nl.configure_gitlinker(cfg)
-- end

gitlinker.setup()

utils.n_keymap("<leader>gy", function() gitlinker.get_buf_range_url("n") end, "Yank url")
utils.v_keymap("<leader>gy", function() gitlinker.get_buf_range_url("v") end, "Yank url for selected")
