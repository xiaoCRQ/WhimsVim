-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

map("i", "jj", "<Esc>", opt)
map("n", "<C-->", ":lua font('-')<CR>", opt)
map("v", "<C-->", ":lua font('-')<CR>", opt)
map("n", "<C-=>", ":lua font('+')<CR>", opt)
map("v", "<C-=>", ":lua font('+')<CR>", opt)
map("n", ";", ":lua Complete_semicolon()<CR>", opt)

for _, mode in ipairs({ "n", "v" }) do
  map(mode, "N", "5j", opt)
  map(mode, "M", "5k", opt)
end

local normal_symbols = {
  [";;"] = ":",
  ["U"] = "<C-r>",
}

for k, v in pairs(normal_symbols) do
  map("n", k, v, opt)
end

local shift_symbols = {
  ["11"] = "!",
  ["22"] = "@",
  ["33"] = "#",
  ["44"] = "$",
  ["55"] = "%",
  ["66"] = "^",
  ["77"] = "&",
  ["88"] = "*",
  ["99"] = "()<left>",
  ["00"] = ")",
}

for k, v in pairs(shift_symbols) do
  map("i", k, v, opt)
end

local pairs_map = {
  ["["] = "[]<left>",
  ["[["] = "{}<left>",
  [",,"] = "<",
  [",,,"] = "<><left>",
  [".."] = ">",
  ["///"] = "?",
  ["\\\\"] = "|",
}

for k, v in pairs(pairs_map) do
  map("i", k, v, opt)
end

local win_map = {
  ["<m-h>"] = "<C-w>h",
  ["<m-l>"] = "<C-w>l",
  ["<m-j>"] = "<C-w>j",
  ["<m-k>"] = "<C-w>k",
  ["<S-W>"] = ":vsp<CR>",
  ["<S-S>"] = ":sp<CR>",
}

for k, v in pairs(win_map) do
  map("n", k, v, opt)
end

local cmd_map = {
  q = ":bd<CR>",
  qq = ":q!<CR>",
  qa = ":qa!<CR>",
  qw = ":wq!<CR>",
  qwa = ":w!<CR>:qa<CR>",
  w = ":w!<CR>",
  wq = ":wq!<CR>",
  wqa = ":w!<CR>:qa<CR>",
}

for k, v in pairs(cmd_map) do
  map("n", k, v, opt)
end

-- 终端缓冲区（非分屏，作为普通缓冲区打开）
map("n", "<leader>tt", function()
  vim.cmd("enew!")
  vim.fn.termopen("fish")
  vim.cmd("startinsert")
end, vim.tbl_extend("force", opt, { desc = "Open fish terminal buffer" }))

function _G.set_terminal_keymaps()
  local opt = { buffer = 0 }

  map("t", "<esc>", [[<C-\><C-n>]], opt)
  map("t", "jj", [[<C-\><C-n>]], opt)

  for _, key in ipairs({ "h", "j", "k", "l" }) do
    map("t", "<C-" .. key .. ">", "<Cmd>wincmd " .. key .. "<CR>", opt)
  end

  -- 命令快捷键（终端模式）
  local t_cmd_map = {
    -- q = [[<C-\><C-n>:bd!<CR>]],
    -- qq = [[<C-\><C-n>:q!<CR>]],
    -- qa = [[<C-\><C-n>:qa!<CR>]],
    -- qw = [[<C-\><C-n>:wq!<CR>]],
    -- qwa = [[<C-\><C-n>:w!<CR>:qa<CR>]],
    -- w = [[<C-\><C-n>:w!<CR>]],
    -- wq = [[<C-\><C-n>:wq!<CR>]],
    -- wqa = [[<C-\><C-n>:w!<CR>:qa<CR>]],
  }

  for k, v in pairs(t_cmd_map) do
    map("t", k, v, opt)
  end

  -- 窗口导航（终端模式）
  local t_win_map = {
    ["<m-h>"] = [[<C-\><C-n><C-w>h]],
    ["<m-l>"] = [[<C-\><C-n><C-w>l]],
    ["<m-j>"] = [[<C-\><C-n><C-w>j]],
    ["<m-k>"] = [[<C-\><C-n><C-w>k]],
  }

  for k, v in pairs(t_win_map) do
    map("t", k, v, opt)
  end

  -- leader组合键（终端模式）
  map("t", "<leader>tt", [[<C-\><C-n>:enew! | call termopen('fish') | startinsert<CR>]], opt)
end

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.bo.modifiable = false
    _G.set_terminal_keymaps()
  end,
})

-- nvim-dap 调试快捷键 (由 LazyVim dap.core 提供 + 自定义 dL)

-- 🟢 启动与控制
-- <leader>dc  继续/启动 (Continue) — 启动调试或运行到下一断点
-- <leader>da  带参数运行 (Run with Args) — 弹出输入框设置命令行参数
-- <leader>dl  重复上次 (Run Last) — 使用上一次的调试配置重新运行
-- <leader>dL  加载 launch.json (Load Config) — 【自定义】向上搜索 .vscode/launch.json 并加载
-- <leader>dt  终止 (Terminate) — 立即停止当前调试会话
-- <leader>dP  暂停 (Pause) — 暂停正在运行的程序
-- <leader>ds  会话信息 (Session) — 查看当前调试会话详情

-- 🔴 断点管理
-- <leader>db  切换断点 (Toggle Breakpoint) — 在当前行添加/移除断点
-- <leader>dB  条件断点 (Condition) — 输入表达式，表达式为真时触发断点
-- <leader>dC  运行到光标 (Run to Cursor) — 程序执行到光标所在行暂停

-- 🟡 步进
-- <leader>dO  单步跳过 (Step Over) — 执行当前行，不进入函数内部
-- <leader>di  单步进入 (Step Into) — 进入当前行的函数内部
-- <leader>do  单步跳出 (Step Out) — 执行完当前函数并返回调用处
-- <leader>dg  跳转到行 (Go to Line) — 跳转执行位置到光标行（跳过中间代码）

-- 🔵 堆栈与界面
-- <leader>dk  堆栈上行 (Stack Up) — 查看调用当前函数的上一层
-- <leader>dj  堆栈下行 (Stack Down) — 查看调用堆栈的下一层
-- <leader>dr  REPL 开关 (Toggle REPL) — 交互式控制台，可输入变量名/表达式求值
-- <leader>dw  悬浮变量 (Widgets Hover) — 悬浮窗口显示光标下变量的值
-- <leader>du  Dap UI 开关 (Toggle UI) — 打开/关闭调试面板 (变量/堆栈/断点列表)
-- <leader>de  求值 (Eval) — 对选中文本或光标处表达式求值 (n/x 模式)
