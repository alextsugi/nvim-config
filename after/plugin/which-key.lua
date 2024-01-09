local wk = require("which-key")
wk.setup()

-- Set names for prefixes only

wk.register({
    g = { name = "Git" },
}, { mode = "v", prefix = "<leader>" })

wk.register({
    l = { name = "LSP" },
    t = { name = "Rest" },
    g = { name = "Git" },
    b = { name = "Buffer" },
    f = { name = "Find" },
    d = { name = "Debug" },
}, { mode = "n", prefix = "<leader>" })
