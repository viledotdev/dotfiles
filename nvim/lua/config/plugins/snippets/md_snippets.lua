local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("dt", {
    -- Insert default template for obsidian note
    t('print("hello'),
    i(1),
    t('lua")'),
  }),
}
