return {
    "nvim-lualine/lualine.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    enabled = true,
    config = function()
        local function keymap()
            return vim.o.iminsert > 0 and vim.o.keymap:sub(1, 2) or ""
        end

        local function paste()
            return vim.o.paste and "PASTE" or ""
        end

        local function vimtex()
            local status = {}

            local vt_local = vim.b.vimtex_local
            table.insert(status, vt_local and vt_local.active == 1 and "l" or "m")

            local vimtex = vim.b.vimtex
            if vimtex then
                local viewer = vimtex.viewer
                if viewer and viewer.xwin_id ~= 0 then
                    table.insert(status, "v")
                end

                local compiler = vimtex.compiler
                if compiler then
                    vim.cmd("let b:vimtex.compiler.is_running_state = b:vimtex.compiler.is_running()")
                    table.insert(status, compiler.is_running_state and "C" or "c")
                    table.insert(status, compiler.continuous == 0 and "₁" or "₊")
                end
            end

            if #status == 0 then
                return ""
            end

            table.insert(status, 1, "{")
            table.insert(status, "}")

            return table.concat(status)
        end

        require("lualine").setup({
            options = {
                theme = "onedark",
                disabled_buftypes = { "nofile" },
            },
            extensions = { "ctrlspace", "lazy", "mundo", "nvim-tree", "symbols-outline", "toggleterm", "trouble" },
            sections = {
                lualine_a = {
                    "mode",
                    keymap,
                    {
                        paste,
                        color = { fg = "red", gui = "bold" },
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        -- shorting_target = 0
                    },
                },
                lualine_x = {
                    {
                        vimtex,
                        cond = function()
                            return vim.o.filetype == "tex"
                        end,
                    },
                    {
                        "encoding",
                        cond = function()
                            return vim.o.fileencoding ~= "utf-8"
                        end,
                    },
                    {
                        "fileformat",
                        cond = function()
                            return vim.o.fileformat ~= "unix"
                        end,
                    },
                    "filetype",
                },
            },
            inactive_sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        -- shorting_target = 0
                    },
                },
            },
        })
    end,
}
