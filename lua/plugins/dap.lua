local dap = require("dap")
local utils = require("neoconfig.utils")

utils.n_keymap("<leader>dc", dap.continue, "Continue/Launch") -- launches a debugger if there is no active session
utils.n_keymap("<leader>ds", dap.step_over, "Over")
utils.n_keymap("<leader>di", dap.step_into, "Into")
utils.n_keymap("<leader>do", dap.step_out, "Out")
utils.n_keymap("<leader>dt", dap.toggle_breakpoint, "Breakpoint")
utils.n_keymap("<leader>dj", dap.run_to_cursor, "Run to cursor")
utils.n_keymap("<leader>du", dap.up, "Up")
utils.n_keymap("<leader>dd", dap.down, "Down")
utils.n_keymap("<leader>dr", dap.restart, "Restart")
utils.n_keymap("<leader>dq", dap.terminate, "Quit/Terminate")

----------------------------------------
-- C/C++/Rust
----------------------------------------
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode

dap.adapters.lldb = {
    type = "executable",
    command = "/opt/homebrew/opt/llvm/bin/lldb-dap", -- must be absolute path
    name = "lldb"
}

local cConfig = {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false, -- read docs before changing
}

dap.configurations.c = { cConfig }
dap.configurations.cpp = dap.configurations.c

local rustConfig = {}
for k, v in pairs(cConfig) do rustConfig[k] = v end

-- Add rust types
rustConfig.initCommands = function()
    -- Find out where to look for the pretty printer Python module
    local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

    local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
    local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

    local commands = {}
    local file = io.open(commands_file, 'r')
    if file then
        for line in file:lines() do
            table.insert(commands, line)
        end
        file:close()
    end
    table.insert(commands, 1, script_import)

    return commands
end
rustConfig.program = function()
    local cwd = vim.fn.getcwd()
    local split = vim.fn.split(cwd, '/')
    local app = split[#split]
    return vim.fn.input("Path to executable: ", cwd .. "/target/debug/" .. app, "file")
end

dap.configurations.rust = { rustConfig }

----------------------------------------
-- Go
----------------------------------------

dap.adapters.delve = {
    type = "server",
    port = "${port}",
    executable = {
        command = "dlv",
        args = { "dap", '-l', "127.0.0.1:${port}" },
    },
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    },
}

----------------------------------------
-- DAP UI
----------------------------------------

local dapui = require("dapui")

-- Open and close automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dapui.setup({
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
        }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = {
        {
            elements = {
                {
                    id = "scopes",
                    size = 0.25
                },
                {
                    id = "breakpoints",
                    size = 0.25
                },
                {
                    id = "stacks",
                    size = 0.25
                },
                {
                    id = "watches",
                    size = 0.25
                }
            },
            position = "left",
            size = 40
        },
        {
            elements = {
                {
                    id = "repl",
                    size = 0.5
                },
                {
                    id = "console",
                    size = 0.5
                }
            },
            position = "bottom",
            size = 10
        }
    },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
})
