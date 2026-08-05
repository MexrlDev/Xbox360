local messages = {
    "Xbox 360 still rocks!",
    "Payload delivered!",
    "Stay frosty.",
    "You're a wizard, Harry.",
    "Achievement unlocked: running LUA",
    "All your base are belong to us",
    "Kernel is a lie",
    "Nova is watching you",
}

local msg = messages[math.random(#messages)]
Script.ShowNotification(msg)
