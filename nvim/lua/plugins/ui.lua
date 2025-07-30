return {
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.startify")

      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }

      alpha.setup(dashboard.opts)
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local theme = require("catppuccin.utils.lualine")
      local flavor = theme("mocha")

      vim.cmd.highlight('MsgArea guibg=#181825')

      require("lualine").setup({
        options = {
          theme = flavor,
          component_separators = {},
          section_separators = { left = '', right = '' },
          extensions = { "nvim-dap-ui" },
          disabled_filetypes = {
            'neo-tree',
            'alpha'
          }
        },
        winbar = {
          lualine_a = { { 'filename', path = 1, symbols = { unnamed = '' }, separator = { left = '', right = '' } } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = { { 'filename', path = 1, symbols = { unnamed = '' } } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '', right = '' } } },
          lualine_b = { 'branch' },
          lualine_c = { { 'filename', path = 1, symbols = { unnamed = '' } }, 'diagnostics' },
          lualine_x = {
            {
              'lsp_status',
              symbols = {
                spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                done = '✓',
                separator = ' ',
              },
              ignore_lsp = { 'tailwindcss' },
            }
          },
          lualine_y = { 'progress' },
          lualine_z = { { 'location', separator = { left = '', right = '' } } },
        },
        inactive_sections = {
          lualine_a = { { 'filename', path = 1, symbols = { unnamed = '' } } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
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
          mappings = {
            ["P"] = {
              "toggle_preview",
              config = {
                use_image_nvim = true,
              },
            },
          }
        }
      })
      vim.keymap.set("n", "<leader>b", ":Neotree filesystem reveal float<CR>", {})
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim"
    },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader> ", builtin.find_files, {})
      vim.keymap.set("n", "<leader>f", builtin.live_grep, {})
      vim.keymap.set("v", "<leader>f", builtin.grep_string, {})
      vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
      vim.keymap.set("n", "<leader>t", builtin.treesitter, {})
      vim.keymap.set("n", "<leader>;", builtin.commands, {})
      vim.keymap.set("n", "<leader>:", builtin.command_history, {})
      vim.keymap.set("n", "<leader>B", builtin.builtin, {})
      require("telescope").load_extension("media_files")
      vim.keymap.set("n", "<leader>M", require('telescope').extensions.media_files.media_files, {})
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

      vim.keymap.set("n", "<C-P>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<C-N>", function()
        harpoon:list():next()
      end)

      harpoon:extend({
        UI_CREATE = function(cx)
          vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-x>", function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })
        end,
      })
    end,
  },
  {
    "3rd/image.nvim",
    commit = "21909e3eb03bc738cce497f45602bf157b396672",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    config = function()
      require("image").setup({
        backend = "kitty",
        kitty_method = "normal",
        processor = "magick_cli", -- or "magick_rock"
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            only_render_image_at_cursor_mode = "popup",
            floating_windows = false,              -- if true, images will be rendered in floating markdown windows
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            filetypes = { "norg" },
          },
          typst = {
            enabled = true,
            filetypes = { "typst" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false,                                               -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
        editor_only_render_when_focused = false,                                            -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false,                                            -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
      })
      require("image").enable()
    end
  }
}
