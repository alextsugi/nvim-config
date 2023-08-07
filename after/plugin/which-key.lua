local wk = require("which-key")
wk.setup()

local opts = { mode = "n" }
wk.register({
  ["<C-n>"] = { "Go to mark 1" },
  ["<C-m>"] = { "Go to mark 2" },
  ["<C-t>"] = { "Go to terminal" },
  ["<leader>z"] = { "Zen Mode" },
  -- <z=> for spelling
}, opts)

opts = { mode = "v", prefix = "<leader>" }
wk.register({
  g = {
    name = "Git",
    y = { "Yank URL" },
    s = { "Stage Hunk" },
    r = { "Reset Hunk" },
  },
  ["/"] = { "Comment Toggle" },
}, opts)

opts = { mode = "n", prefix = "<leader>" }
wk.register({
  q = { "Quit" },
  m = { "Mark File" },
  u = { "Undo Tree" },
  ["/"] = { "Comment Toggle" },
  t = {
    name = "Rest",
    t = { "Execute request" },
  },
  g = {
    name = "Git",
    y = { "Yank URL" },
    g = { "Stage Hunk" },
    r = { "Reset Hunk" },
    u = { "Undo Stage Hunk" },
    b = { "Toggle Line Blame" },
    d = { "Diff" },
    D = { "Diff ~" },
    p = { "Preview Hunk" },
    S = { "Stage Buffer" },
    R = { "Reset Buffer" },
  },
  n = { "New file" },
  v = { "Split Vertically" },
  h = { "Split Horizontally" },
  c = { "No Highlight" },
  b = {
    name = "Buffer",
    ["]"] = { "Resize Plus" },
    ["["] = { "Resize Minus" },
  },
  f = {
    name = "Find",
    b = { "Marked Files" },
    f = { "File" },
    g = { "Grep" },
    r = { "Open Recent File" },
    k = { "Keymaps" },
    p = { "Projects" },
    H = { "Help" },
    C = { "Commands" },
    R = { "Registers" },
    M = { "Man Pages" },
  },
}, opts)
