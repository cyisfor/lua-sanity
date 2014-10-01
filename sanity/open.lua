return function(name,handler,fail)
    local file = nil
    if fail == nil then -- fail == false for silent failure
        fail = error
    end
    local results = {pcall(function()
        file = io.open(name,'rb')
        if not file then
            if fail then 
                fail("file not found "..name)
            end
        else
            return handler(file)
        end
    end)}
    local ok = table.remove(results,1)
    if file then file:close() end
    if not ok and fail then
        fail(unpack(results))
    end
    return unpack(results)
end

