-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local m = {}
local buf_set_keymap = vim.api.nvim_buf_set_keymap

local ts_builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

-- better moving betting
vim.keymap.set("n", "L", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "H", "<C-w>h", { noremap = true, silent = true })

vim.keymap.set("i", "jj", "<ESC>", { silent = true })
vim.keymap.set("i", "kj", "()<Left>", { silent = true })
vim.keymap.set("i", "df", "{}<Left>", { silent = true })
vim.keymap.set("v", "p", '"_dp"')
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<C-e>", "<Cmd>Neotree toggle<CR>")

vim.keymap.set("n", "<C-s>", ":wa!<CR>", opts)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", opts)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>gv", opts)

-- better vertical splitting
vim.keymap.set("n", "<leader>v", "<C-w>v", { noremap = true, silent = true })

-- undotree
vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", {})
-- vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", opts)

--Neotree
vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
vim.keymap.set("n", "<leader>ge", function()
    require("neo-tree.command").execute({ source = "git_status", toggle = true })
end, { desc = "Git Explorer" })

-- Telescope searching
vim.keymap.set(
    "n",
    "<leader>,",
    "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
    { desc = "Switch Buffer" }
) -- Ctrl-b - search current buffers
vim.keymap.set(
    "n",
    "<leader>i",
    ts_builtin.current_buffer_fuzzy_find,
    { desc = "Live fuzzy search inside of the currently open buffer (<leader>i)", silent = true }
)

vim.keymap.set("n", "<leader>j", ts_builtin.live_grep, { desc = "Search in your current directory", silent = true })

-- spectre ( search and replace )
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search and replace on current file",
})

-- Copilot Ctrl-l to accept the suggestion
vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', { expr = true, script = true, replace_keycodes = false })

-- better searching
vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })

-- GIT
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git Status" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git Branches" })

-- LSP
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<space>ff", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", {})
vim.keymap.set("n", "<space>d", "<cmd>Telescope diagnostics<CR>", {})
vim.keymap.set("n", "<space>d", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})

-- GIT

-- LSP
function m.lsp_keybindings_for_buffer(bufnr)
    -- buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
    buf_set_keymap(bufnr, "n", "<S-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
    buf_set_keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", {})
    -- buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
    buf_set_keymap(bufnr, "n", "<S-r>", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
    buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", {})
    buf_set_keymap(bufnr, "n", "st", "<cmd>Telescope git_status<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
    buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
    buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>Telescope diagnostics<CR>", {})
    buf_set_keymap(bufnr, "n", "<leader>ff", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", {})
end

return m
