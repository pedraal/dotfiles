return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup()
    end,
  },
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
      ensure_installed = {
        "denols@2.2.7",
        "biome@1.9.4",
        "eslint@4.10.0",
        "html@4.10.0",
        "jsonls@4.10.0",
        "lua_ls@3.13.9",
        "stylelint_lsp@2.0.1",
        "tailwindcss@0.14.13",
        "ts_ls@4.3.4",
        "volar@2.2.6",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
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

      local vue_language_server_path = nil
      local mason_registry_ok, mason_registry = pcall(require, "mason-registry")

      if mason_registry_ok then
        local vue_pkg_ok, vue_pkg = pcall(function()
          return mason_registry.get_package('vue-language-server')
        end)

        if vue_pkg_ok and vue_pkg then
          vue_language_server_path = vue_pkg:get_install_path()
        end
      end

      local ts_config = {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
        on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      }

      if vue_language_server_path then
        ts_config.init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
              languages = { 'vue' },
            },
          },
        }
      end

      lspconfig.ts_ls.setup(ts_config)

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
        root_dir = lspconfig.util.root_pattern("eslint.config.js", "eslint.config.mjs", ".eslintrc.cjs", ".eslintrc.js"),
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
      -- lspconfig.gopls.setup({
      -- 	capabilities = capabilities,
      -- })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.gleam.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.rename, {})
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
  -- {
  -- 	"ray-x/go.nvim",
  -- 	dependencies = {
  -- 		"ray-x/guihua.lua",
  -- 		"neovim/nvim-lspconfig",
  -- 		"nvim-treesitter/nvim-treesitter",
  -- 	},
  -- 	config = function()
  -- 		require("go").setup()
  --
  --
  -- 		vim.api.nvim_create_autocmd("BufWritePre", {
  -- 			pattern = "*.go",
  -- 			callback = function()
  -- 				require('go.format').goimports()
  -- 			end,
  -- 			group = format_sync_grp,
  -- 		})
  -- 	end,
  -- 	event = { "CmdlineEnter" },
  -- 	ft = { "go", 'gomod' },
  -- 	build = ':lua require("go.install").update_all_sync()'
  -- },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
  }
}
