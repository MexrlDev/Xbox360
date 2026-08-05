function main()
    local version = _VERSION or "Lua 5.1 (Aurora)"
    Aurora.SetMessage("Lua version: " .. tostring(version), "bottom")
end
