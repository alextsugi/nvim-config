local utils = require("neoconfig.utils")

require('Comment').setup()

utils.n_keymap("<leader>/", "<Plug>(comment_toggle_linewise_current)", "Comment line")
utils.v_keymap("<leader>/", "<Plug>(comment_toggle_linewise_visual)", "Comment selection")
