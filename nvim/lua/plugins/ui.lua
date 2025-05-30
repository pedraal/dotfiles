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
          lualine_x = {},
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
        -- window = {
        --   position = "right",
        -- },
        -- event_handlers = {
        --   {
        --     event = "file_open_requested",
        --     handler = function()
        --       require("neo-tree.command").execute({ action = "close" })
        --     end
        --   },
        -- }
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
    "sphamba/smear-cursor.nvim",
    opts = {
      cursor_color = "#d3cdc3",
      normal_bg = "#282828",
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      use_floating_windows = true,
      legacy_computing_symbols_support = false,
    },
  },
}
