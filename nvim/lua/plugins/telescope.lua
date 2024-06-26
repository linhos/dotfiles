return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" }, -- Required by telescope
        { "nvim-telescope/telescope-ui-select.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make", -- This plugin requires compilation
        },
    },
    -- TODO: See if we can write this config without the below (in lazy.nvim, we should be able to skip it??)
    config = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
            },
        })
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("fzf")
    end,
}
