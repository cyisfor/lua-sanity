package="sanity"
version="0.1-1"
source = {
    url="git@github.com:cyisfor/lua-sanity.git"
}
description = {
   summary = "Idioms to make Lua a bit saner for certain operations",
   homepage = "http://github.com/cyisfor/lua-sanity/",   
   detailed = [[
       sanity.open - a safe way to open files without needing to explicitly close them
       sanity.pcall - a sane version of pcall that doesn't throw away the stack trace on error
       sanity.replacer - a sane way to replace a file as atomically as possible, preserving attributes
   ]]
}

dependencies = {
   "lua >= 5.1",
}

build = {
   type="builtin",
   modules = {
       ["sanity.open"] = "sanity/open.lua",
       ["sanity.pcall"] = "sanity/pcall.lua",
       ["sanity.replacer"] = "sanity/replacer.lua",
   }
}
