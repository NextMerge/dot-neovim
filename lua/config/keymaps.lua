-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- The standard
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Break out of insert mode' })

-- Overwrites
vim.keymap.set('n', 'h', '<Nop>', { desc = 'No h' })
vim.keymap.set('n', 'l', '<Nop>', { desc = 'No l' })

vim.keymap.set('n', '<C-Left>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
vim.keymap.set('n', '<C-Right>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })

vim.keymap.set('n', '<C-h>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-l>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Custom
vim.keymap.set(
  'x',
  '<leader>p',
  '"_dP',
  { desc = "[P]aste over highlighted text but don't overwrite the copy register" }
)
vim.keymap.set('x', '<leader>d', [["_d]], { desc = '[D]elete without writing to the copy register' })
vim.keymap.set({ 'n', 'x' }, 'x', '"_x', { desc = 'Delete character without copying to register' })

vim.keymap.set('n', '<C-@>', 'q', { desc = 'Start/Stop recording a macro' })
vim.keymap.set('n', 'q', '<Nop>')
vim.keymap.set('n', 'Q', '<Nop>')

vim.keymap.set({ 'n', 'x' }, '<C-q>', 'ZZ', { desc = 'Save and quit' })

vim.keymap.set({ 'n', 'x' }, '"', ':', { desc = 'Command Prompt' })
vim.keymap.set({ 'n', 'x' }, ':', '"')

vim.keymap.set({ 'n', 'x' }, '<C-d>', '<C-d>zz', { desc = 'Move down and center screen on cursor' })
vim.keymap.set({ 'n', 'x' }, '<C-u>', '<C-u>zz', { desc = 'Move up and center screen on cursor' })

vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down a line' })
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up a line' })

vim.keymap.set({ 'n', 'x' }, 'U', '<C-r>', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<C-r>', 'U', { noremap = true })

vim.keymap.set('n', '<leader>yf', ':let @+=expand("%")<CR>', { desc = 'Yank [F]ilepath' })
vim.keymap.set('n', '<leader>yF', ':let @+=expand("%:p")<CR>', { desc = 'Yank Absolute [F]ilepath' })
vim.keymap.set('n', '<leader>yd', ':let @+=expand("%:p:h")<CR>', { desc = 'Yank [D]irectory' })

vim.keymap.set('n', '<leader>ox', function()
  local r, c = unpack(vim.api.nvim_win_get_cursor(0))
  local escaped_path = vim.fn.shellescape(vim.fn.expand('%:p'))
  vim.cmd(string.format(
    'silent !cursor -r --folder-uri file://%s -g %s:%s:%s',
    vim.fn.getcwd(),
    escaped_path,
    r,
    c + 1 -- Add 1 to convert from 0-indexed to 1-indexed
  ))
end, { desc = '[O]pen E[x]ternal editor' })

local function fileIsFishCLI()
  -- check that the opened file ends with "/tmp.*.fish"
  local file = vim.fn.expand('%:p')
  return string.match(file, '/tmp.*%.fish$')
end

if fileIsFishCLI() then
  vim.keymap.set('n', 'q', ':q<CR>', { desc = 'Quit' })
end
