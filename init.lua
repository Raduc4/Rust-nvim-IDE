vim.opt.mouse = ""
vim.opt.number = true
vim.opt.laststatus = 2
vim.opt.wildmode = "longest,list"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.autoindent = true
	vim.cmd [[autocmd BufWritePost * GitGutter]]
	vim.cmd [[autocmd BufNewFile,BufRead *.fish set syntax=bash]]
	vim.cmd [[highlight SignColumn ctermbg=none]]
	vim.cmd [[highlight GitGutterAdd    ctermfg=12]]
	vim.cmd [[highlight GitGutterChange ctermfg=13]]
	vim.cmd [[highlight GitGutterDelete ctermfg=1]]
	vim.cmd [[let g:gitgutter_set_sign_backgrounds = 1]]

        vim.api.nvim_set_keymap( 'n', 'm;', ':Files <CR>', {noremap = true}) 	
	vim.api.nvim_set_keymap( 'n', '<C-Up>', '<C-W><C-K>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<C-Down>', '<C-W><C-J>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<C-Right>', '<C-W><C-L>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<C-Left>', '<C-W><C-H>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<F2>', ':set invnu <CR>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<F3>', ':set mouse=a <CR>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<F4>', ':set mouse="" <CR>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<F5>', ':terminal % <CR>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<F5>', ':! cargo run --quiet <CR>', {noremap = true})
	vim.api.nvim_set_keymap( 'n', '<F6>', ':w <CR>', {noremap = true})
	vim.api.nvim_set_keymap( 'i', '<F6>', '<ESC> :w <CR>', {noremap = true})
        vim.api.nvim_set_keymap( 'n', 'n;', ':GFiles <CR>', {noremap = true}) 	

	require('plugins')
	require'lspconfig'.rust_analyzer.setup({})
	
        local autosave = require("autosave")

        autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)

	local cmp = require'cmp'
	cmp.setup({
	  mapping = {
	    ['<C-p>'] = cmp.mapping.select_prev_item(),
	    ['<C-n>'] = cmp.mapping.select_next_item(),
	    -- Add tab support
	    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
	    ['<Tab>'] = cmp.mapping.select_next_item(),
	    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	    ['<C-f>'] = cmp.mapping.scroll_docs(4),
	    ['<C-Space>'] = cmp.mapping.complete(),
	    ['<C-e>'] = cmp.mapping.close(),
	    ['<CR>'] = cmp.mapping.confirm({
	      behavior = cmp.ConfirmBehavior.Insert,
	      select = true,
	    })
	  },
	
	  -- Installed sources
	  sources = {
	    { name = 'nvim_lsp' },
	    { name = 'path' },
	    { name = 'buffer' },
	  },
	})
	
	
	require('lualine').setup {
	  options = {
	    icons_enabled = false,
	    theme = 'gruvbox_dark',
	    component_separators = { left = '', right = ''},
	    section_separators = { left = '', right = ''},
	    disabled_filetypes = {},
	    always_divide_middle = true,
	  },
	  sections = {
	    lualine_a = {'mode'},
	    lualine_b = {'branch', 'diff', 'diagnostics'},
	    lualine_c = {'filename'},
	    lualine_x = {'encoding', 'fileformat', 'filetype'},
	    lualine_y = {'progress'},
	    lualine_z = {'location'}
	  },
	  inactive_sections = {
	    lualine_a = {},
	    lualine_b = {},
	    lualine_c = {'filename'},
	    lualine_x = {'location'},
	    lualine_y = {},
	    lualine_z = {}
	  },
	  tabline = {
	    lualine_a = {'buffers'},
	    lualine_b = {'branch'},
	    lualine_c = {'filename'},
	    lualine_x = {},
	    lualine_y = {},
	    lualine_z = {'tabs'}
	  },
	  extensions = {}
	}
	
	local opts = { noremap=true, silent=true }
	vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	
	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
	  -- Enable completion triggered by <c-x><c-o>
	  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	
	  -- Mappings.
	  -- See `:help vim.lsp.*` for documentation on any of the below functions
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	end
	
	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = { 'rust_analyzer'}
	for _, lsp in pairs(servers) do
	  require('lspconfig')[lsp].setup {
	    on_attach = on_attach,
	    flags = {
	      -- This will be the default in neovim 0.7+
	      debounce_text_changes = 150,
	    }
	  }
	end
	vim.cmd [[colorscheme tokyonight]]
