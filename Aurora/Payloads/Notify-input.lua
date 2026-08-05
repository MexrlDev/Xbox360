function main()
    local ret = Script.ShowKeyboard("Custom Notification", "Type your message:", "", 0)
    if not ret.Canceled and ret.Buffer ~= "" then
        Script.ShowNotification(ret.Buffer)
    else
        Script.ShowNotification("Cancelled")
    end
end
