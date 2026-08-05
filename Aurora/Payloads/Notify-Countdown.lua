function main()
    for i = 5, 1, -1 do
        Script.ShowMessageBox("Countdown", "Countdown: " .. i, "Continue")
    end
    Script.ShowNotification("Blast off!")
end
