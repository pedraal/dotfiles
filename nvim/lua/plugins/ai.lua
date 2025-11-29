local is_light_config = os.getenv("NVIM_LIGHT_CONFIG") ~= nil

return {
  {
    "supermaven-inc/supermaven-nvim",
    cond = not is_light_config,
    config = function()
      require("supermaven-nvim").setup({
        ignore_filetypes = { "neo-tree", "neo-tree-popup" }
      })
    end,
  },
  {
    'NickvanDyke/opencode.nvim',
    cond = not is_light_config,
    config = function()
      vim.g.opencode_opts = {
        provider = {
          enabled = "tmux",
          tmux = {
            -- ...
          }
        }
      }

      vim.o.autoread = true

      vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end,
        { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<leader>ox", function() require("opencode").select() end,
        { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "x" }, "<leader>oA", function() require("opencode").prompt("@this") end,
        { desc = "Add to opencode" })
      vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end,
        { desc = "Toggle opencode" })
      -- vim.keymap.set("n", "<C-U>", function() require("opencode").command("session.half.page.up") end,
      --   { desc = "opencode half page up" })
      -- vim.keymap.set("n", "<C-D>", function() require("opencode").command("session.half.page.down") end,
      --   { desc = "opencode half page down" })
    end,
  }
}
