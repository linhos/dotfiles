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
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files)" })
        vim.keymap.set("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
        vim.keymap.set("n", "<leader>s", "<cmd>Telescope registers<cr>", { desc = "Registers" })
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("fzf")
    end,
}
