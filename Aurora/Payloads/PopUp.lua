-- Hello-Popup.lua
local ret = Script.ShowMessageBox(
    "Hello",
    "Hello from POPUP :D",
    "Go Away",
    "Thanks!"
)

if ret.Button == 1 then
    Script.ShowNotification("Okay, bye! 👋")
elseif ret.Button == 2 then
    Script.ShowNotification("You're welcome! 😊")
end
