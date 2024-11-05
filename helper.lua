function Add_nums(...)
    local args = {...}
    local sum = 0
    for i = 1, #args do
       sum = sum + tonumber(args[i])
    end
    return sum
end

return {
    Add_nums = Add_nums
}