return {
    "echasnovski/mini.nvim",
    branch = "stable",
    config = function()
        -- require("mini.pairs").setup()
        require("mini.surround").setup()
        require("mini.comment").setup()
        require("mini.starter").setup()
        require("mini.trailspace").setup()
        -- require("mini.indentscope").setup()
    end,
}
