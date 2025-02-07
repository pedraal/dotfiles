return {
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
	}
}
