vim.api.nvim_create_autocmd('FileType', {
	pattern = 'http',
	once = true,
	callback = function()
		require('kulala').setup {}
		vim.keymap.set('n', '<leader>rr', function() require('kulala').run() end, { desc = 'Run request' })
		vim.keymap.set('n', '<leader>rl', function() require('kulala').replay() end,
			{ desc = 'Replay last request' })
		vim.keymap.set('n', '<leader>ri', function() require('kulala').inspect() end,
			{ desc = 'Inspect request' })
	end,
})
