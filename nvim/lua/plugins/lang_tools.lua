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
    version = "1.11.0",
    lazy = false,
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "1.32.0",
    lazy = false,
    opts = {
      ensure_installed = {
        "biome@1.9.4",
        "eslint@4.10.0",
        "html@4.10.0",
        "jsonls@4.10.0",
        "lua_ls@3.13.9",
        "stylelint_lsp@2.0.1",
        "tailwindcss@0.14.13",
        "ts_ls@4.3.4",
        "volar@2.2.10",
        "templ@v0.3.865"
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local mason_registry = require('mason-registry')
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
          '/node_modules/@vue/language-server'

      local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }
      local vtsls_config = {
        capabilities = capabilities,
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },
        filetypes = tsserver_filetypes,
        on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      }

      local vue_ls_config = {
        capabilities = capabilities,
        on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      }

      lspconfig.vtsls.setup(vtsls_config)
      lspconfig.volar.setup(vue_ls_config)
      lspconfig.denols.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      })
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("Gemfile"),
        init_options = {
          formattee = 'rubocop',
          linters = { 'rubocop' },
        },
        addonSettings = {
          ["Ruby LSP Rails"] = {
            enablePendingMigrationsPrompt = false,
          },
        },
      })
      lspconfig.biome.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("biome.json", "biome.jsonc"),
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      lspconfig.stylelint_lsp.setup({
        capabilities = capabilities,
        settings = {
          autoFixOnSave = true
        }
      })
      lspconfig.eslint.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("eslint.config.js", "eslint.config.mjs", ".eslintrc.cjs", ".eslintrc.js"),
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })
      lspconfig.templ.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.gleam.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "gf", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {})
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {})
      vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, {})

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
  },
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
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" }
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    config = function()
      require("lazydev").setup({
        library = { "nvim-dap-ui" },
      })
    end,
  },
}
