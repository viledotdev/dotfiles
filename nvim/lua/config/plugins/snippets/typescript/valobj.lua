local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
  s("valobj", {
    -- Encabezado de la clase
    t({ "export class " }),
    i(1, "ClassName"),
    t({ " {", "  #value: " }),
    i(2, "typename"),
    t(";"),
    t({ "", "" }),
    -- Constructor
    t({ "  constructor(value?: " }),
    rep(2),
    t({ ") {" }),
    t({ "if(!this.#validate(value))" }),
    t({ "throw new Error('error');" }),
    t({ "this.#value = value;" }),
    t({ "  }", "" }),
    -- Getter
    t({ "  get value(): " }),
    rep(2),
    t({ " {" }),
    t({ "    return this.#value;" }),
    t({ "  }", "" }),
    -- Método privado de validación (opcional)
    t({ "  #validate(value?: " }),
    rep(2),
    t({ "): boolean {" }),
    t({ "if(value === undefined) return false;" }),
    t({ "    return true" }),
    t({ "  }", "" }),
    t({ "  }", "" }),
  }),
}
