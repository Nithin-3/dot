
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    require('icon-picker').setup {
      disable_legacy_commands = true,
    }

    vim.keymap.set('n', '<leader>ei', '<cmd>IconPickerNormal<CR>',  { desc = 'Icon picker' })
    vim.keymap.set('n', '<leader>ee', '<cmd>IconPickerNormal emoji<CR>', { desc = 'Emoji picker' })
    vim.keymap.set('i', '<C-e>',      '<cmd>IconPickerInsert emoji<CR>', { desc = 'Insert emoji' })
  end,
})
