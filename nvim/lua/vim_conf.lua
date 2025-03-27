vim.opt.termguicolors = true

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set shortmess+=csCFSW")
vim.cmd("set cc=80")
vim.cmd("set scrolloff=8")
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.winbar = "%f"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", opts)

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("n", "<Esc>", "<Esc>:noh<CR>", opts)

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.jade",
	command = "set filetype=pug",
})

vim.api.nvim_create_user_command('Wf', function()
	local file_path = vim.fn.expand('%:p')
	vim.fn.setreg('+', file_path)
	vim.notify("Copied: " .. file_path)
end, {})
