require('mini.snippets').setup()
require('mini.pairs').setup()
require('mini.ai').setup()
require('mini.basics').setup {}
require('mini.surround').setup {}

require('mini.files').setup {
  windows = {
    preview = true,
    max_number = 3,
    width_preview = 60,
  },
  mappings = {
    close       = 'q',
    go_in       = 'L',
    go_in_plus  = 'l',  -- go in and close explorer
    go_out      = 'H',
    go_out_plus = 'h',  -- go out to root
    mark_goto   = "'",
    mark_set    = 'm',
    reset       = '<BS>',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = '=',  -- apply file operations
    trim_left   = '<',
    trim_right  = '>',
  },
}

vim.keymap.set('n', '\\f', function()
  require('mini.files').open(vim.uv.cwd())
end, { desc = 'MiniFiles open cwd', silent = true })

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

-- close
    map('\\', function()
      require('mini.files').close()
    end, 'Close MiniFiles')

    -- delete
    map('dd', function()
      local entry = require('mini.files').get_fs_entry()
      if not entry then return end
      local confirm = vim.fn.confirm('Delete ' .. entry.name .. '?', '&Yes\n&No', 2)
      if confirm == 1 then
        vim.fn.delete(entry.path, entry.fs_type == 'directory' and 'rf' or '')
        require('mini.files').refresh()
      end
    end, 'Delete entry')

    -- rename
    map('r', function()
      local entry = require('mini.files').get_fs_entry()
      if not entry then return end
      local new_name = vim.fn.input('Rename: ', entry.name)
      if new_name == '' or new_name == entry.name then return end
      local new_path = vim.fn.fnamemodify(entry.path, ':h') .. '/' .. new_name
      vim.fn.rename(entry.path, new_path)
      require('mini.files').refresh()
    end, 'Rename entry')

    -- create file
    map('a', function()
      local entry = require('mini.files').get_fs_entry()
      if not entry then return end
      local dir = entry.fs_type == 'directory' and entry.path
        or vim.fn.fnamemodify(entry.path, ':h')
      local name = vim.fn.input('New file: ', dir .. '/')
      if name == '' then return end
      vim.fn.mkdir(vim.fn.fnamemodify(name, ':h'), 'p')
      vim.fn.writefile({}, name)
      require('mini.files').refresh()
    end, 'Create file')

    -- create directory
    map('A', function()
      local entry = require('mini.files').get_fs_entry()
      if not entry then return end
      local dir = entry.fs_type == 'directory' and entry.path
        or vim.fn.fnamemodify(entry.path, ':h')
      local name = vim.fn.input('New dir: ', dir .. '/')
      if name == '' then return end
      vim.fn.mkdir(name, 'p')
      require('mini.files').refresh()
    end, 'Create directory')
  end,
})
