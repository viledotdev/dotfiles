local cmp = require("cmp")

local M = {}

M.on_confirm_done = function(funcs)
  if type(funcs) ~= "table" then
    return
  end
  for _, func in ipairs(funcs) do
    if type(func) == "function" then
      cmp.event:on("confirm_done", func)
    end
  end
end

return M
