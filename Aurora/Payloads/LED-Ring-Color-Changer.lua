local colours = {
    { name = "Green",   val = 0x00FF00 },
    { name = "Red",     val = 0xFF0000 },
    { name = "Blue",    val = 0x0000FF },
    { name = "Orange",  val = 0xFF6600 },
    { name = "White",   val = 0xFFFFFF },
    { name = "Cyan",    val = 0x00FFFF },
    { name = "Magenta", val = 0xFF00FF },
    { name = "Yellow",  val = 0xFFFF00 },
    { name = "Off",     val = 0x000000 },
}

function main()
    local idx = 1
    while true do
        local colour = colours[idx]
        local changed = pcall(function()
            Led.SetColor(colour.val)
        end)
        if changed then
            Script.ShowNotification("LED set to " .. colour.name)
        else
            Script.ShowNotification("LED API not available on this Aurora build")
            break
        end
        local ret = Script.ShowMessageBox(
            "LED Cycler",
            "Current: " .. colour.name .. "\n\nPress Continue for next colour, or Cancel to exit.",
            "Continue", "Cancel"
        )
        if ret.Canceled or ret.Button == 2 then
            break
        end
        idx = idx % #colours + 1
    end
end
