local utils = require("neoconfig.utils")

require("gitsigns").setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { buffer = bufnr }

        -- Actions
        utils.n_keymap('<leader>gs', gs.stage_hunk, "Stage hunk", opts)
        utils.n_keymap('<leader>gr', gs.reset_hunk, "Reset hunk", opts)
        utils.n_keymap('<leader>gu', gs.undo_stage_hunk, "Undo stage hunk", opts)
        utils.n_keymap('<leader>gb', gs.toggle_current_line_blame, "Blame", opts)
        utils.n_keymap('<leader>gd', function() gs.diffthis('~') end, "Diff", opts)
        utils.n_keymap('<leader>gp', gs.preview_hunk, "Preview hunk", opts)
        utils.n_keymap('<leader>gS', gs.stage_buffer, "Stage buffer", opts)
        utils.n_keymap('<leader>gR', gs.reset_buffer, "Reset buffer", opts)

        utils.v_keymap('<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage hunk", opts)
        utils.v_keymap('<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset hunk", opts)

        -- Text object
        utils.keymap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select hunk", opts)
    end
})
