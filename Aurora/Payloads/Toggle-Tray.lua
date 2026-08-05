if Aurora.GetDVDTrayState() == 0 then
    Aurora.CloseDVDTray()
    Script.ShowNotification("Closing DVD tray")
else
    Aurora.OpenDVDTray()
    Script.ShowNotification("Opening DVD tray")
end
