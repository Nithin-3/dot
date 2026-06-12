vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.wrap = true
vim.o.winborder = 'rounded'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.g.have_nerd_font = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+yy', { desc = 'Yank line to system clipboard' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>w', '<cmd>wa<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit window' })
vim.keymap.set('n', '<leader>Q', '<cmd>q!<cr>', { desc = 'Force quit' })
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.diagnostic.config {
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = vim.diagnostic.severity.ERROR },
	virtual_text = { prefix = '󱡁' },
	virtual_lines = true,
	jump = { float = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '󰀪',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.HINT] = '',
		},
	},
}

vim.api.nvim_set_hl(0, 'YankHighlight', {
	bg = '#019606',
	fg = '#000000',
})
vim.api.nvim_set_hl(0, 'Search', {
	bg = '#019606',
	fg = '#000000',
})
vim.api.nvim_set_hl(0, 'CurSearch', {
	bg = '#98cb8a',
	fg = '#000000',
})
vim.api.nvim_set_hl(0, 'Cursor', {
	fg = '#000000',
	bg = '#019606',
})

vim.api.nvim_set_hl(0, 'lCursor', {
	fg = '#000000',
	bg = '#019606',
})
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank {
			higroup = 'YankHighlight',
		}
	end,
})

vim.pack.add {
	-- UI / Themes
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/nyoom-engineering/oxocarbon.nvim',
	'https://github.com/EdenEast/nightfox.nvim.git',

	-- LSP / Development
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',

	-- Autocomplete / Snippets
	{ src = 'https://github.com/Saghen/blink.cmp', version = "1.*", build = "cargo build --release", },
	'https://github.com/rafamadriz/friendly-snippets',

	-- Fuzzy Finding / Telescope
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	{
		src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
		build = vim.fn.executable 'make' == 1 and 'make' or nil,
	},
	'https://github.com/nvim-telescope/telescope-ui-select.nvim',

	-- Utilities / Core Enhancements
	'https://github.com/echasnovski/mini.nvim',
	'https://github.com/folke/which-key.nvim',
	'https://github.com/karb94/neoscroll.nvim',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/folke/todo-comments.nvim',

	-- File Explorer / Navigation
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/nvim-neo-tree/neo-tree.nvim',

	-- UI Components / Statusline / Terminal
	'https://github.com/nvim-lualine/lualine.nvim',
	'https://github.com/akinsho/toggleterm.nvim',
	'https://github.com/MunifTanjim/nui.nvim',

	-- Fun / Visual Extras
	'https://github.com/sphamba/smear-cursor.nvim.git',
	'https://github.com/allaman/emoji.nvim',
	'https://github.com/ziontee113/icon-picker.nvim',

	-- rest api
	'https://github.com/mistweaverco/kulala.nvim',
}

-- Auto-import every *.lua file in lua/plugins/
local plugins_dir = vim.fn.stdpath 'config' .. '/lua/plugins'
for _, path in ipairs(vim.fn.glob(plugins_dir .. '/*.lua', false, true)) do
	local mod = 'plugins.' .. vim.fn.fnamemodify(path, ':t:r')
	local ok, err = pcall(require, mod)
	if not ok then vim.notify('Error loading ' .. mod .. ':\n' .. err, vim.log.levels.ERROR) end
end

-- ============================================
-- AUTO RELOAD FILE ON EXTERNAL CHANGE
-- ============================================
vim.o.autoread = true

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
	pattern = '*',
	callback = function()
		if vim.fn.mode() ~= 'c' then
			vim.cmd 'checktime'
		end
	end,
})

vim.cmd.colorscheme 'default'

vim.api.nvim_set_hl(0, "FloatBorder", {
	fg = "#019606",
	bg = "NONE",
})
