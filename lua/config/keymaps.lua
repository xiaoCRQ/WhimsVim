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

function _G.set_terminal_keymaps()
  local opt = { buffer = 0 }

  map("t", "<esc>", [[<C-\><C-n>]], opt)
  map("t", "jj", [[<C-\><C-n>]], opt)

  for _, key in ipairs({ "h", "j", "k", "l" }) do
    map("t", "<C-" .. key .. ">", "<Cmd>wincmd " .. key .. "<CR>", opt)
  end

  map("t", "qq", [[<C-\><C-n><C-w>]], opt)
end

-- nvim-dap
-- 🟢 启动与控制 (Execution Control)
-- <leader>dc (Run/Continue): 启动调试会话，或者如果程序已暂停，则继续运行到下一个断点。
-- <leader>da (Run with Args): 运行程序并允许输入自定义参数（需要 get_args 函数支持）。
-- <leader>dl (Run Last): 重新运行最后一次使用的调试配置。
-- <leader>dL (Load VSCode Launch Config (Upward Search)): 加载新配置。
-- <leader>dt (Terminate): 立即停止当前的调试会话。
-- <leader>dP (Pause): 暂停正在运行的程序。
-- <leader>ds (Session): 获取当前调试会话的对象信息。

-- 🔴 断点管理 (Breakpoints)
-- <leader>db (Toggle Breakpoint): 在当前行切换断点（开启或关闭）。
-- <leader>dB (Breakpoint Condition): 设置条件断点。按下后会弹出输入框，只有当输入的表达式为真时，程序才会在此处暂停。
-- <leader>dC (Run to Cursor): 让程序一直运行，直到到达光标所在的行。

-- 🟡 步进操作 (Stepping)
-- <leader>dO (Step Over): 单步跳过。执行当前行，不进入函数内部，直接停在下一行。
-- <leader>di (Step Into): 单步进入。如果当前行有函数调用，则进入该函数内部。
-- <leader>do (Step Out): 单步跳出。运行完当前函数剩余部分，并在返回调用处时暂停。
-- <leader>dg (Go to Line): 强制将执行位置跳转到当前光标行，但不执行中间的代码（慎用，可能会导致状态异常）。

-- 🔵 堆栈与界面 (UI & Stack)
-- <leader>dk (Up): 在调用堆栈中向上移动（查看调用当前函数的上一层代码）。
-- <leader>dj (Down): 在调用堆栈中向下移动。
-- <leader>dr (Toggle REPL): 打开/关闭交互式控制台（REPL），你可以在这里输入变量名查看值或执行代码段。
-- <leader>dw (Widgets): 弹出悬浮窗口显示当前光标下变量的值或相关调试组件。
