local utils = require("neoconfig.utils")

require("rest-nvim").setup()
require("telescope").load_extension("rest")

utils.n_keymap("<leader>tt", "<cmd>Rest run<cr>", "Run request under the cursor")
utils.n_keymap("<leader>te", require("telescope").extensions.rest.select_env, "Select request env file")
