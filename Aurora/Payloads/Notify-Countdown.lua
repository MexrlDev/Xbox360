-function main()
    for i = 5, 1, -1 do
        Script.ShowNotification("Countdown: " .. i)
        -- wait 1 second using a simple busy loop
        local target = os.time() + 1
        while os.time() < target do
        end
    end
    Script.ShowNotification("Blast off!")
end
