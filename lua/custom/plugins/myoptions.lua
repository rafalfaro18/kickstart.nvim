vim.o.relativenumber = true

-- character widht column
vim.opt.colorcolumn = "80" -- the standard. Good for livestreaming / recording with OpenDyslexic nerd font mono size 13

-- Tab options might conflict with lsp indentantion, golang might need custom settings to use tabs specifically disabling expandtab
vim.opt.tabstop = 4      -- Number of spaces a <Tab> in the file counts for
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.softtabstop = 4  -- Number of spaces a <Tab> counts for while performing editing operations

-- 0.12+ Sets the default border for all floating windows: LSP hover, signature help, diagnostics floats, everything.
vim.opt.winborder = "rounded"

-- For buffers to auto-reload after a file is written. Recommended by Cannon07/code-preview.nvim docs.
-- Automatically read a file changed outside of Neovim
vim.o.autoread = true

-- Trigger checktime on various events to reload buffers out of focus
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

