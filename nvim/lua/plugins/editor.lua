return {
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	-- Automatically add closing tags for HTML and JSX
	-- {
	-- 	"windwp/nvim-ts-autotag",
	-- 	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	-- 	opts = {},
	-- },
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
	}
}
