return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local function is_eslint_active()
				local clients = vim.lsp.get_active_clients()
				for _, client in ipairs(clients) do
					if client.name == "eslint" then
						return true
					end
				end
				return false
			end


			local mason_registry = require('mason-registry')
			local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path()

			local lspconfig = require("lspconfig")
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.gleam.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
				on_attach = function(client, _)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				init_options = {
					plugins = {
						{
							name = '@vue/typescript-plugin',
							location = vue_language_server_path,
							languages = { 'vue' },
						},
					},
				},
				-- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
			})
			lspconfig.denols.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			})
			lspconfig.biome.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("biome.json", "biome.jsonc"),
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.stylelint_lsp.setup({
				capabilities = capabilities,
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("eslint.config.js", "eslint.config.mjs", ".eslintrc.cjs"),
			})
			lspconfig.volar.setup({
				capabilities = capabilities,
				on_attach = function(client, _)
					if is_eslint_active() then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
				end,
				init_options = {
					vue = {
						hybridMode = false
					}
				}
			})

			vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "ff", vim.lsp.buf.format, {})
			vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "gD", vim.diagnostic.open_float, {})

			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()


			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require('go.format').goimports()
				end,
				group = format_sync_grp,
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
		build = ':lua require("go.install").update_all_sync()'
	}
}
