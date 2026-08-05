function main()
    local version = _VERSION or "Lua 5.1 (Aurora)"
    Script.ShowNotification("Lua version: " .. tostring(version))
end
