require('emoji').setup()

-- Defer until after all plugins (including telescope) are loaded
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    local ts = require('telescope').load_extension 'emoji'
    vim.keymap.set('n', '<leader>se', ts.emoji, { desc = '[S]earch [E]moji' })
    vim.keymap.set('i', '<C-e>', ts.emoji, { desc = 'Insert emoji' })
  end,
})
