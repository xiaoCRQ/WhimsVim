local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local code_path = vim.fn.expand("~/Work/Program/CodeForces")

-- 基础控制
map("n", "<leader>cda", ":FOJ<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 开始刷题" }))
map("n", "<leader>cdq", ":FOJ stop<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 停止刷题" }))
map("n", "<leader>cdr", ":FOJ submit<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 提交代码" }))

-- 评测与 UI
map("n", "<leader>cdt", ":FOJ run<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 编译并评测" }))
map("n", "<leader>cdT", ":FOJ test<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 仅评测 (不编译)" }))
map("n", "<leader>cdu", ":FOJ show<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 判题 UI 开关" }))
map("n", "<leader>cde", ":FOJ edit<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 编辑测试案例" }))

-- 数据管理
map("n", "<leader>cds", ":FOJ solve<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 标记题目已解决" }))
map("n", "<leader>cdS", ":FOJ solve back<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 撤销解决标记" }))
map("n", "<leader>cdd", ":FOJ erase<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 删除题目数据" }))

-- 快速浏览 (查找器)
map("n", "<leader>cdc", ":FOJ find template<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 查找模板文件" }))
map("n", "<leader>cdP", ":FOJ find problem<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 查找历史题目" }))
map("n", "<leader>cdj", ":FOJ find data<CR>", vim.tbl_extend("force", opts, { desc = "FOJ: 查找题目数据" }))

-- 对拍
map(
  "n",
  "<leader>cdp",
  ":FOJ stress correct=find: test=find:<CR>",
  vim.tbl_extend("force", opts, { desc = "FOJ: 对拍器" })
)

return {
  {
    "xiaocrq/faster-oj.nvim",
    dir = "~/Work/Program/Project/faster-oj.nvim",
    opts = {
      -- debug = true,
      -- obscure = false,
      warning_msg = true,
      clipboard_submit = true,
      work_dir = code_path,
      temp_dir = code_path .. "/.temp",
      data_dir = code_path .. "/.problem",
      solve_dir = code_path .. "/.solve",
      template_dir = code_path .. "/.template",
      template_default = code_path .. "/.template/template.cpp",
      template_default_ext = ".cpp",
      -- code_obfuscator = {
      --   result = ".obfuscator/" .. "$(FNAME)",
      --   cmd = {
      --     exec = "obfuscator_cpp",
      --     args = {
      --       "$(FABSPATH)",
      --       ".obfuscator/" .. "$(FNAME)",
      --       "-h",
      --       cf_path .. "/.head",
      --       -- "-l",
      --       -- "-n",
      --       "-s",
      --       "Orz orz",
      --     },
      --   },
      -- },
    },
  },
}
