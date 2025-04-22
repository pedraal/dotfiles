vim.cmd("set shortmess+=csCFSW")

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.termguicolors = true

vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

vim.opt.number = true
vim.opt.relativenumber = true

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
