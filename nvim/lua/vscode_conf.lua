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

keymap({ "n", "v" }, "<leader>ga", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({ "n", "v" }, "<leader>gi", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>")
keymap({ "n", "v" }, "<leader>gt", "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>")
keymap({ "n", "v" }, "<leader> ", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({ "n", "v" }, "<leader>:", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
keymap({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap({ "n", "v" }, "<leader>e", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap({ "n", "v" }, "<leader>E", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
