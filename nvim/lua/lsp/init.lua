-- Setup how diagnostics should appear in neovim
local function setup_lsp_diagnostics()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
end

setup_lsp_diagnostics()

-- Better auto completion capabilities (expand the built in ones)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
-- Make mason and lspconfig work together nicely
require("mason-lspconfig").setup()

-- Ensure LSP servers and formatters are installed through Mason
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "tsserver",
        "eslint",
        "cssls",
        "tailwindcss",
        -- Formatters
        "eslint_d",
        "prettierd",
        "stylua",
    },
})

local lspconfig = require("lspconfig")

-- Lua
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the "vim" global
                globals = { "vim" },
            },
        },
    },
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- ESLint (Typescipt and Javascript)
lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- CSS
lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})

-- TailwindCSS
lspconfig.tailwindcss.setup({})

-- Typescript
lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.document_highlight then
            vim.api.nvim_exec(
                [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]],
                false
            )
        end

        -- this way we keep keybindings in one place
        require("keybindings").lsp_keybindings_for_buffer(bufnr)
    end,
})
