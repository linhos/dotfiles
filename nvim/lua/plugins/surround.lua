return {
    "echasnovski/mini.surround",
    keys = {
        { "gza", desc = "Add Surrounding" },
        { "gzd", desc = "Delete Surrounding" },
        { "gzf", desc = "Find Surrounding Right" },
        { "gzF", desc = "Find Surrounding Left" },
        { "gzv", desc = "Highlight Surrounding" },
        { "gzr", desc = "Replace Surrounding" },
        { "gzn", desc = "Update N Lines" },
    },
    opts = {
        mappings = {
            add = "gza", -- Add surroundina in Normal and Visual modes
            delete = "gzd", -- Delete surrounding
            find = "gzf", -- Find surrounding (to the right)
            find_left = "gzF", -- Find surrounding (to the left)
            highlight = "gzv", -- Highlight surrounding
            replace = "gzr", -- Replace surrounding
            update_n_lines = "gzn", -- Update `n_lines`

            suffix_last = "l", -- Suffix to search with "prev" method
            suffix_next = "n", -- Suffix to search with "next" method
        },
    },
}
