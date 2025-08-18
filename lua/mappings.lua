require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('x', '<C-c>', '"+y', { desc = "Copy to clipboard" })

map({'n', 'v'}, '<leader>fs', function()
 require('telescope.builtin').grep_string()
end, { desc = 'Telescope Grep String (current word/selection)' })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
