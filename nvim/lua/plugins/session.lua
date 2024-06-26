return {
    {
        "olimorris/persisted.nvim",
        config = function()
            vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"
            require("persisted").setup({
                autoload = true,
            })
            require("telescope").load_extension("persisted")
            vim.keymap.set("n", "<leader>ql", ":Telescope persisted<CR>", { noremap = true, silent = true })
        end,
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
}
