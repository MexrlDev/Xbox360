function main()
    for i = 5, 1, -1 do
        Script.ShowNotification("Countdown: " .. i)
        Aurora.SetScriptTimeout(1000)   -- wait 1 second
        Aurora.Sleep(1000)              -- if Sleep is available; else use a busy loop
    end
    Script.ShowNotification("Blast off!")
end
