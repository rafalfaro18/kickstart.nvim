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
