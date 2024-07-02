return {
    "kazhala/close-buffers.nvim",
    config = function()
        vim.keymap.set(
            "n",
            "<leader>bd",
            [[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]],
            { noremap = true, silent = true }
        )
    end,
}
