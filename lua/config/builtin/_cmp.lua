-- [[ Configure nvim-cmp ]]--
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').lazy_load({paths = "~/.config/nvim/lua/snippets"})
luasnip.config.setup {}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	
	-- Configuration pour désactiver dans certains contextes
	enabled = function()
		-- Désactiver dans les commentaires
		local context = require('cmp.config.context')
		if context.in_treesitter_capture('comment') or context.in_syntax_group('Comment') then
			return false
		end
		
		-- Désactiver après les mots-clés de déclaration
		local line = vim.api.nvim_get_current_line()
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local before_cursor = line:sub(1, col)
		
		-- Pattern pour détecter les déclarations
		if before_cursor:match('%s*class%s+%w*$') then
			return false
		end
		if before_cursor:match('%s*struct%s+%w*$') then
			return false
		end
		if before_cursor:match('%s*void%s+%w*$') then
			return false
		end
		if before_cursor:match('%s*int%s+%w*$') then
			return false
		end
		if before_cursor:match('%s*bool%s+%w*$') then
			return false
		end
		if before_cursor:match('%s*std::string%s+%w*$') then
			return false
		end
		-- Ajoute d'autres types si besoin
		
		return true
	end,
	
	window = {
		completion = {
			max_height = 10,
			max_width = 50,
		},
		documentation = {
			max_height = 10,
			max_width = 60,
		},
	},
	
	formatting = {
		fields = { 'abbr', 'kind', 'menu' },
		format = function(entry, item)
			if #item.abbr > 40 then
				item.abbr = string.sub(item.abbr, 1, 37) .. '...'
			end
			
			item.menu = ({
				nvim_lsp = '[LSP]',
				luasnip = '[Snip]',
				buffer = '[Buf]',
			})[entry.source.name]
			
			return item
		end,
	},
	
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		
		['<Down>'] = cmp.mapping.select_next_item(),
		['<Up>'] = cmp.mapping.select_prev_item(),
		
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}
