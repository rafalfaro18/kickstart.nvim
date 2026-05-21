
-- Claude Code reference copier (no plugin, just a script)

local function copy_claude_ref()
  -- Exit visual mode to lock selection
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
    "x",
    false
  )

  -- Get selected line range
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Get relative file path
  local filepath = vim.fn.expand("%:.")

  if filepath == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.WARN)
    return
  end

  -- Build reference
  local ref
  if start_line == end_line then
    ref = string.format("@%s#L%d", filepath, start_line)
  else
    ref = string.format("@%s#L%d-%d", filepath, start_line, end_line)
  end

  -- Copy to clipboard (+ register)
  vim.fn.setreg("+", ref)

  -- Notify user
  vim.notify("Copied: " .. ref, vim.log.levels.INFO)
end

-- Keymap: visual mode <leader>r
vim.keymap.set("v", "<leader>r", copy_claude_ref, {
  desc = "Copy Claude Code reference",
  silent = true,
})
