local ls = require("luasnip")
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

local useState = s(
    "STATE",
    fmt(
        [[ 
const [{}, set{}] = useState()
]]       ,
        {
            i(1, "state"),
            f(function(arg, _)
                return arg[1][1]:gsub("^%l", string.upper)
            end, 1),
        }
    )
)

local controlledComponent = s(
    "CONTROLLEDCOMP",
    fmt(
        [[ 
        value={{{}}}
        onChange={{(e) => set{}(e.target.value)}}
]]       ,
        {
            i(1, "state"),
            f(function(nodes, _)
                return nodes[1][1]:gsub("^%l", string.upper)
            end, 1),
        }
    )
)

local functionComponent = s(
    "FUNCTIONCOMP",
    fmt(
        [[ 
        function {} ({}) {{
          return (
          <>
             {}
          </>
        )}}
        ]],
        {
            i(1, "FuncName"),
            i(2, ""),
            i(0), --> 0 is the last position of the cursor when we're done editing the snippet
        }
    )
)

table.insert(snippets, useState)
table.insert(snippets, functionComponent)
table.insert(snippets, controlledComponent)

return snippets, autosnippets
