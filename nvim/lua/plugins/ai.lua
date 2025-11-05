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
    ---@type opencode.Opts
    opts = {
      -- Your configuration, if any — see lua/opencode/config.lua
    },
    keys = {
      { '<leader>oA', function() require('opencode').ask() end,                  desc = 'Ask opencode', },
      { '<leader>oa', function() require('opencode').ask('@cursor: ') end,       desc = 'Ask opencode about this',      mode = 'n', },
      { '<leader>oa', function() require('opencode').ask('@selection: ') end,    desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>ot', function() require('opencode').toggle() end,               desc = 'Toggle embedded opencode', },
      { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
      { '<leader>op', function() require('opencode').select_prompt() end,        desc = 'Select prompt',                mode = { 'n', 'v', }, },
    },
  }
}
