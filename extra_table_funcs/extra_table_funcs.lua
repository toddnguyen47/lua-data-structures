---@param list_input table
---Print all key/value pairs of the table 'list_input'
function table.print(list_input)
  for k, v in pairs(list_input) do print(string.format("Key: [%s], Value: %s", k, v)) end
end
