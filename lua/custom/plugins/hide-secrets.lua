-- Hides secrets in files like .env
vim.pack.add { 'https://github.com/Gentleman-Programming/veil.nvim' }

require("veil").setup({
  -- Add extra patterns - simple keywords or full patterns
  extra_patterns = {
    "POSTGRES_URL",      -- Simple keyword
    "NEXT_PUBLIC_SUPABASE_URL",    -- Another keyword
  },
})
