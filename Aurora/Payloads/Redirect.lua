local TARGET_URL = "https://raw.githubusercontent.com/MexrlDev/Xbox360/refs/heads/main/Aurora/Payloads/Secret.lua"

function main()
    Script.SetStatus("Downloading target script...")
    Script.SetProgress(0)
    local http = Http.Get(TARGET_URL)
    if not http.Success then
        Script.ShowNotification("Failed to download target script")
        return
    end
    Script.SetProgress(100)

    Script.SetStatus("Running target script...")

    main = nil
    local chunk, compileErr = load(http.OutputData, "Secret.lua")
    if not chunk then
        Script.ShowNotification("Invalid Lua script: " .. compileErr)
        return
    end

    local runOk, runErr = pcall(chunk)
    if not runOk then
        Script.ShowNotification("Execution error: " .. tostring(runErr))
        return
    end

    if type(main) == "function" then
        local mainOk, mainErr = pcall(main)
        if not mainOk then
            Script.ShowNotification("Error in main(): " .. tostring(mainErr))
        end
    end
end
