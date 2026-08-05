local state = 0
pcall(function() state = Aurora.GetDVDTrayState() end)
if state == 0 then
    pcall(function() Aurora.OpenDVDTray() end)
    Script.ShowNotification("Opening DVD tray")
else
    pcall(function() Aurora.CloseDVDTray() end)
    Script.ShowNotification("Closing DVD tray")
end
