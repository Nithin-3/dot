require('toggleterm').setup {
  size = 15,
  direction = 'float',
  open_mapping = [[<c-\>]],
  float_opts = {
    border = 'curved',
    width = 100,
    height = 30,
    winblend = 3,
  },
  highlights = {
    border = 'FloatBorder',
    background = 'Normal',
  },
}

-- Exit terminal mode with <Esc>
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
