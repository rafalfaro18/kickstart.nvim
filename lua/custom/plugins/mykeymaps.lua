vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Hover Documentation" })

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
