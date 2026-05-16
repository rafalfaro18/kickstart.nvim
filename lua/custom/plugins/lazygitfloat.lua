vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }

require("toggleterm").setup {
  direction = "float",
  float_opts = {
    border = "rounded",
  }
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "rounded"
  }
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {
  noremap = true,
  silent = true,
  desc = "LazyGit (float)"
})

