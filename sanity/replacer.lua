local ffi = require('ffi')
local pcall = require('sanity.pcall')

ffi.cdef[[
int close(int fd);
int mkstemp(uint8_t* template);
int chmod(const char *path, int mode);
]]

local delete = {}

return function(dest,base,handler)
    dest = tostring(dest)
    if handler == nil then
        handler = base
        base = '.temp'
    else
        base = tostring(base)
    end
    base = base .. 'XXXXXX';

    local tempname = ffi.new("uint8_t[?]", #base, base)
    local holder = nil
    local out = nil
    ok,e = pcall(function()
        holder = ffi.C.mkstemp(tempname)
        tempname = ffi.string(tempname)
        out = io.open(tempname,'w')
        ffi.C.close(holder)
        holder = nil
        handler(out,delete,tempname)
    end)
    if ok and e ~= delete then
        ffi.C.chmod(tempname,6 * 64 + 4 * 8 + 4)
        os.remove(dest)
        assert(os.rename(tempname,dest))
    else
        os.remove(tempname)
    end
    if holder then
        ffi.C.close(holder)
    end
    if out then        
        -- note pcall(out.close,out) FAILS for some reason
        pcall(function()
            out:close()
        end)
    end
    assert(ok,e)
    return e
end
