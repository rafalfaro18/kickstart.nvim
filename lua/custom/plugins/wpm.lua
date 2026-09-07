vim.pack.add { 'https://github.com/iliailmer/nvim-wpm' }

require("nvim-wpm").setup({
  window_ms = 10000,              -- rolling window size, in milliseconds (default 10000)
  format = "%d wpm",              -- string.format template, or a function(n: number): string
})

local statusline = require('mini.statusline')
local original_location = statusline.section_location

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function(args)
  if vim.fn.mode(1) == 'i' then
    return original_location(args) .. ' ' .. require("nvim-wpm").wpm()
  end
  return original_location(args)
end
