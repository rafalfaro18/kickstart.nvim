vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Hover Documentation" })

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>wa', '<cmd>wa<CR>', { desc = 'Write all modified buffers' })

vim.keymap.set('n', '<leader>mf', function()
  vim.lsp.buf.code_action({
    context = {
      diagnostics = {},
      only = { 'refactor.move' }
    },
    apply = true,
  })
end, { desc = "LSP Move to new file" })

vim.keymap.set('n', '<leader>gh', function()
  require('telescope.builtin').live_grep({
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden', 
      '--glob=!.git/',   -- Excludes the internal Git data directory
      '--glob=!.git*',   -- Excludes .gitattributes, .gitignore, .gitmodules, etc.
    },
  })
end, { desc = 'Live grep including hidden (excludes git files & .git/)' })

vim.keymap.set('n', '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'Debug: Hover Variable' })
vim.keymap.set({'n', 'v'}, '<leader>de', function() require('dapui').eval() end, { desc = 'Debug: Evaluate Under Cursor' })
-- Sync scroll: set on both windows first then scroll
vim.keymap.set("n", "<leader>sb", function()
    -- Parentheses ensure the equality check happens before the "not" operator
    vim.opt.scrollbind = not (vim.v.option_type == "global") and not vim.opt.scrollbind:get()
    print("Scrollbind: " .. tostring(vim.opt.scrollbind:get()))
end, { desc = "Toggle scrollbind (sync) for current window" })
