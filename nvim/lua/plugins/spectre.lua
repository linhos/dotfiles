return {
    "nvim-pack/nvim-spectre",
    config = function()
        vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
            desc = "Toggle Spectre",
        })
        vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectrek).open_file_search({select_word=true })<CR>', {
            desc = "Search and replace on current file",
        })
        vim.keymap.set("n", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
            desc = "Search current word",
        })
    end,
}
