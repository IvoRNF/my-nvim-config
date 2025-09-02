require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "typescript", "typescriptreact", "typescript.tsx" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
