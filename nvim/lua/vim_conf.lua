vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.wo.relativenumber = true

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<c-h>", ":wincmd h<CR>", opts)
keymap("n", "<c-j>", ":wincmd j<CR>", opts)
keymap("n", "<c-k>", ":wincmd k<CR>", opts)
keymap("n", "<c-l>", ":wincmd l<CR>", opts)

keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap({ "n", "v" }, "<leader>p", '"+p', opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)
