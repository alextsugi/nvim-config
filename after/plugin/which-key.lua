local wk = require("which-key")
wk.setup()

local opts = { mode = "n" }
wk.register({
  ["<C-n>"] = { "Go to mark 1" },
  ["<C-m>"] = { "Go to mark 2" },
  ["<C-t>"] = { "Go to terminal" },
  ["<leader>z"] = { "Zen Mode" },
  K = { "Code Actions" },
  g = {
    name = "Go To",
    d = { "Definition" },
    i = { "Implementations" },
    r = { "References" },
  },
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
  a = { "Code Actions" },
  l = {
    name = "LSP",
    r = { "Rename" },
    f = { "Format" },
    s = { "Buffer Symbols" },
    S = { "Workspace Symbols" },
    d = { "Buffer Diagnostics" },
    D = { "Workspace Diagnostics" },
    n = { "Next Diagnostic" },
    p = { "Previous Diagnostic" },
  },
  e = { "Explorer" },
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
    m = { "Marked Files" },
    f = { "File" },
    g = { "Grep" },
    r = { "Open Recent File" },
    k = { "Keymaps" },
    p = { "Projects" },
    H = { "Help" },
    C = { "Commands" },
    R = { "Registers" },
    M = { "Man Pages" },
    b = { "Opened Buffers" },
  },
  d = {
    name = "Debug",
    c = { "Continue/Launch" },
    s = { "Step Over" },
    i = { "Step Into" },
    o = { "Step Out" },
    t = { "Toggle Breakpoint" },
    j = { "Run to Cursor" },
    r = { "Restart" },
    q = { "Quit" },
  },
  D = { "Databases" },
  Z = { "Zen Mode" },
}, opts)
