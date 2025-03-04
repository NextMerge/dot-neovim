-- patch which-key.nvim to allow the m key to be an auto trigger
vim.fn.system("sed -i '' 's/\\^\\[gz\\]\\$/\\^\\[gzm\\]\\$/' " .. vim.fn.stdpath("data") .. "/lazy/which-key.nvim/lua/which-key/buf.lua")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
