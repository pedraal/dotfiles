local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap({ "n", "v" }, "<leader>p", '"+p', opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

keymap({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
-- keymap({ "n", "v" }, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({ "n", "v" }, "<leader>ga", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({ "n", "v" }, "<leader>gf", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
-- keymap({ "n", "v" }, "<leader>gi", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>")
-- keymap({ "n", "v" }, "<leader>gt", "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>")
-- keymap({ "n", "v" }, "<leader>b", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>")
keymap({ "n", "v" }, "<leader> ", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({ "n", "v" }, "<leader>P", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")

keymap({ "n", "v" }, "<leader>ha", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap({ "n", "v" }, "<leader>ho", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap({ "n", "v" }, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
