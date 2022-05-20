-- Allows :source $MYVIMRC to work alongisde require(<module>)
local load = function(mod)
	package.loaded[mod] = nil
	return require(mod)
end

load("impatient")
load("plugins")
load("mappings")
load("options")
--> Plugins <--
load("telescope-setup")
load("completions-setup")
load("lsp")
load("null-ls-setup")
load("treesitter-setup")
load("autopairs-setup")
load("vimwiki-setup")
load("luasnip-setup")
load("nvimtree-setup")
load("lualine-setup")
load("trouble-setup")
load("harpoon-setup")
load("quick-scope-setup")
load("friendly-snippets-setup")
load("leap-setup")
-- load("dressing-setup")

-- [TEST]
-- automatically detects missing TS parsers for current ft
-- and prompts to install it (you can black list parsers via the ask_install table)
local ask_install = {}

function EnsureTSParserInstalled()
	local parsers = require("nvim-treesitter.parsers")
	local lang = parsers.get_buf_lang()

	if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
		vim.schedule_wrap(function()
			local is_confirmed = false
			-- TODO: implement a Y/n prompt util func
			print("Install treesitter parser for " .. lang .. " ? Y/n")
			local res = U.get_char_input()
			if res:match("\r") then
				is_confirmed = true
			end
			if res:match("y") then
				is_confirmed = true
			end
			if res:match("Y") then
				is_confirmed = true
			end
			U.clear_prompt()

			if is_confirmed then
				vim.cmd("TSInstall " .. lang)
			else
				ask_install[lang] = false
			end
		end)()
	end
end

-- TODO: convert to auto group
vim.cmd([[au FileType * :lua EnsureTSParserInstalled()]])
