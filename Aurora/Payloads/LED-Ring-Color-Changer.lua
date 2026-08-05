local colours = {
    { name = "Green",   code = 0x00FF00 },
    { name = "Red",     code = 0xFF0000 },
    { name = "Blue",    code = 0x0000FF },
    { name = "Orange",  code = 0xFF6600 },
    { name = "White",   code = 0xFFFFFF },
    { name = "Cyan",    code = 0x00FFFF },
    { name = "Magenta", code = 0xFF00FF },
    { name = "Yellow",  code = 0xFFFF00 },
    { name = "Off",     code = 0x000000 },
}

function main()
    local idx = 1
    local ledAvailable = false
    if Led and type(Led.SetColor) == "function" then
        ledAvailable = pcall(function() Led.SetColor(colours[1].code) end)
        if ledAvailable then
            Script.ShowNotification("LED API active – cycling ring light")
        end
    end

    if not ledAvailable then
        Script.ShowNotification("LED API not found – showing colour names instead")
    end

    while true do
        local c = colours[idx]
        if ledAvailable then
            pcall(function() Led.SetColor(c.code) end)
        end

        local prompt = "Current colour: " .. c.name
        if ledAvailable then
            prompt = prompt .. "\n(Ring LED is now " .. c.name .. ")"
        else
            prompt = prompt .. "\n(LED hardware not available)"
        end

        local ret = Script.ShowMessageBox(
            "LED Cycler",
            prompt .. "\n\nPress Continue for next colour, or Cancel to exit.",
            "Continue", "Cancel"
        )

        if ret.Canceled or ret.Button == 2 then
            break
        end

        idx = idx % #colours + 1
    end

    if ledAvailable then
        pcall(function() Led.SetColor(0x00FF00) end)
        Script.ShowNotification("LED restored to green")
    end
end
