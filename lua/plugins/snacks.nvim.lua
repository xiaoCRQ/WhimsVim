local CMD = "chafa --symbols solid --scale max --clear --probe off "
-- local CMD = "chafa --format kitty --scale max --align=mid --clear "
return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    terminal = {
      shell = "fish",
    },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "l", desc = "LeetCode", action = ":Leet" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
         ██╗  ██╗██╗ █████╗  ██████╗  ██████╗██████╗  ██████╗
         ╚██╗██╔╝██║██╔══██╗██╔═══██╗██╔════╝██╔══██╗██╔═══██╗
          ╚███╔╝ ██║███████║██║   ██║██║     ██████╔╝██║   ██║
          ██╔██╗ ██║██╔══██║██║   ██║██║     ██╔══██╗██║▄▄ ██║
         ██╔╝ ██╗██║██║  ██║╚██████╔╝╚██████╗██║  ██║╚██████╔╝
         ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝ ╚══██═╝]],
      },
      sections = {
        {
          section = "terminal",
          cmd = CMD .. vim.fn.stdpath("config") .. "/lua/logo/v-3.gif ",
          height = 18,
          padding = 1,
        },
        {
          pane = 2,
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
