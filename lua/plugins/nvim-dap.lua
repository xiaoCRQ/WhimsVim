return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dL",
        function()
          local dap = require("dap")
          local dap_vscode = require("dap.ext.vscode")
          local launch_json = vim.fs.find(".vscode/launch.json", {
            path = vim.fn.expand("%:p:h"),
            upward = true,
            stop = vim.loop.os_homedir(),
          })[1]

          if launch_json then
            dap.configurations = {}
            dap_vscode.load_launchjs(launch_json, {
              ["codelldb"] = { "c", "cpp", "rust" },
              ["debugpy"] = { "python" },
            })
            vim.notify("已加载: " .. vim.fn.fnamemodify(launch_json, ":~:."), vim.log.levels.INFO)
          else
            vim.notify("未找到 .vscode/launch.json", vim.log.levels.WARN)
          end
        end,
        desc = "加载 launch.json 配置 (Load VSCode Config)",
      },
    },
  },

  -- C++ (codelldb) / Python (debugpy) 调试器自动安装
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "codelldb", "debugpy" },
    },
  },
}
