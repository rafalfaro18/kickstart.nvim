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
