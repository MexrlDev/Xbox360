if Aurora.GetDVDTrayState() == 0 then
    Aurora.OpenDVDTray()
    Script.ShowNotification("Opening DVD tray")
else
    Aurora.CloseDVDTray()
    Script.ShowNotification("Closing DVD tray")
end
