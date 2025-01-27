return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						visible = true,
						never_show = {
							".DS_Store",
							".git",
						},
					},
				},
				window = {
					position = "right",
				},
			})
			vim.keymap.set("n", "<leader>b", ":Neotree filesystem reveal right<CR>", {})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader> ", builtin.find_files, {})
			vim.keymap.set("n", "<leader>f", builtin.live_grep, {})
			vim.keymap.set("v", "<leader>f", builtin.grep_string, {})
			vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
			vim.keymap.set("n", "<leader>t", builtin.treesitter, {})
			vim.keymap.set("n", "<leader>B", builtin.builtin, {})
			require("telescope").load_extension("media_files")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<leader>e", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			-- vim.keymap.set("n", "<C-h>", function()
			-- 	harpoon:list():select(1)
			-- end)
			-- vim.keymap.set("n", "<C-t>", function()
			-- 	harpoon:list():select(2)
			-- end)
			-- vim.keymap.set("n", "<C-n>", function()
			-- 	harpoon:list():select(3)
			-- end)
			-- vim.keymap.set("n", "<C-s>", function()
			-- 	harpoon:list():select(4)
			-- end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-P>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-N>", function()
				harpoon:list():next()
			end)

			-- local conf = require("telescope.config").values
			-- local function toggle_telescope(harpoon_files)
			-- 	local file_paths = {}
			-- 	for _, item in ipairs(harpoon_files.items) do
			-- 		table.insert(file_paths, item.value)
			-- 	end
			--
			-- 	require("telescope.pickers")
			-- 		.new({}, {
			-- 			prompt_title = "Harpoon",
			-- 			finder = require("telescope.finders").new_table({
			-- 				results = file_paths,
			-- 			}),
			-- 			previewer = conf.file_previewer({}),
			-- 			sorter = conf.generic_sorter({}),
			-- 		})
			-- 		:find()
			-- end
			--
			-- vim.keymap.set("n", "<C-e>", function()
			-- 	toggle_telescope(harpoon:list())
			-- end, { desc = "Open harpoon window" })
		end,
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		lsp = {
	-- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
	-- 			},
	-- 		},
	-- 		-- you can enable a preset for easier configuration
	-- 		presets = {
	-- 			bottom_search = false,    -- use a classic bottom cmdline for search
	-- 			command_palette = true,   -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = false,       -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = false,   -- add a border to hover docs and signature help
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	}
	-- }
}
