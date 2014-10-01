local function traceback(e) 
    return debug.traceback(e,2)
end

local function betterpcall(f)
    return xpcall(f,traceback)
end

return betterpcall
