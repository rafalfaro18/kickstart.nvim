vim.pack.add { 'https://github.com/folke/flash.nvim' }

require("flash").setup{}

local set_map = vim.keymap.set

set_map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash. cl for original keymap" })

set_map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter. cc for original keymap" })

set_map("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })

set_map({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

set_map({ "c" }, "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })
