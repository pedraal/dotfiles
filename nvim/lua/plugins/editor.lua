return {
  {
    "christoomey/vim-tmux-navigator",
    vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>"),
    vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>"),
    vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>"),
    vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>"),
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
    'echasnovski/mini.pairs',
    version = '*',
    config = function()
      require("mini.pairs").setup({})
    end,
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
    config = function()
      require("mini.comment").setup({
        hooks = {
          pre = function()
            require('ts_context_commentstring.internal').update_commentstring()
          end,
        },
      })
    end,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require("mini.surround").setup({})
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 1
        }
      })
    end,
  },
}
