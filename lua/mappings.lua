require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({"n","i"}, "<leader>qq", "<cmd>lua vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR, open = true })<cr>", { desc = "Populate Quickfix List with Diagnostics Errors" })
map("x", "<C-c>", '"+y', { desc = "Copy to clipboard" })

map({ "n" }, "<leader>w", function()
  -- vim.lsp.buf.format { async = false }
  vim.cmd "write"
  vim.cmd "!yarn run change"
end, { desc = "format then save" })

map({ "n", "v" }, "<leader>fs", function()
  require("telescope.builtin").grep_string()
end, { desc = "Telescope Grep String (current word/selection)" })

map({ "i" }, "<leader>k", function()
  vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot Accept", noremap = true, silent = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
