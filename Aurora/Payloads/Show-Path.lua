local path = "N/A"
pcall(function() path = Script.GetBasePath() end)
Script.ShowNotification("Payload path: " .. path)
