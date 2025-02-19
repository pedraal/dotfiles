return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = true,
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"tpope/vim-sleuth",
		version = '*',
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		'echasnovski/mini.nvim',
		version = '*',
	},
	{
		'echasnovski/mini.trailspace',
		version = '*',
		config = function()
			require("mini.trailspace").setup({})
		end,
	},
	{
		"3rd/image.nvim",
		version = '*',
		build = false,
		opts = {
			processor = "magick_cli"
		}
	},
	{
		"nvim-pack/nvim-spectre",
		version = '*',
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup()

			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", {})
			vim.keymap.set("n", "<leader>gl", ":Gitsigns toggle_current_line_blame<CR>", {})
			vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", {})
			vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<CR>", {})
		end
	},
}
