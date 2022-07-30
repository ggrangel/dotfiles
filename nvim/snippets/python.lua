local ls = require "luasnip"
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

local read_N = s("READN", { t "N = int(input())" })

table.insert(snippets, read_N)

return snippets, autosnippets
