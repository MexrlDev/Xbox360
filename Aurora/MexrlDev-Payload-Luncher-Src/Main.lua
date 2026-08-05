--  Script Metadata
scriptTitle       = "MexrlDev Payloads"
scriptAuthor      = "MexrlDev"
scriptVersion     = 5
scriptDescription = "Browse and execute payloads from MexrlDev's GitHub repo"
scriptPermissions = { "http", "filesystem" }


--  Configuration
local BASE_RAW_URL = "https://raw.githubusercontent.com/MexrlDev/Xbox360/refs/heads/main/Aurora/Payloads/"
local STRUCTURE_URL = BASE_RAW_URL .. "structure.txt"


--  Fetch payload list from GitHub
function fetchPayloadList()
    Script.SetStatus("Fetching payload list...")
    Script.SetProgress(0)
    local http = Http.Get(STRUCTURE_URL)
    if not http.Success then
        return nil, "Failed to download structure.txt"
    end
    Script.SetProgress(100)

    local plist = {}
    for line in http.OutputData:gmatch("[^\r\n]+") do
        line = line:match("^%s*(.-)%s*$")
        if line ~= "" then
            table.insert(plist, line)
        end
    end

    if #plist == 0 then
        return nil, "No payloads found"
    end

    return plist
end


--  Build the full popup list (all payloads, no pages)
function buildList()
    local list = {}
    -- Refresh button always first
    table.insert(list, "[ ! ] Refresh List")

    for _, filename in ipairs(payloads) do
        local name = filename:gsub("%.lua$", "")
        table.insert(list, name)
    end

    return list
end


--  Execute a payload (download in memory, run)
function downloadAndExecute(filename)
    local url = BASE_RAW_URL .. filename

    Script.SetStatus("Downloading " .. filename .. "...")
    Script.SetProgress(0)
    local http = Http.Get(url)
    if not http.Success then
        Script.ShowNotification("Download failed for " .. filename)
        return false
    end
    Script.SetProgress(100)

    Script.SetStatus("Running " .. filename .. "...")

    main = nil

    local chunk, compileErr = load(http.OutputData, filename)
    if not chunk then
        Script.ShowNotification("Invalid Lua file: " .. compileErr)
        return false
    end

    local runOk, runErr = pcall(chunk)
    if not runOk then
        Script.ShowNotification("Execution error: " .. tostring(runErr))
        return false
    end

    if type(main) == "function" then
        local mainOk, mainErr = pcall(main)
        if not mainOk then
            Script.ShowNotification("Error in main(): " .. tostring(mainErr))
            return false
        end
    end

    Script.ShowNotification(filename .. " executed successfully!")
    return true
end


--  Main entry point
function main()
    if Aurora.HasInternetConnection() ~= true then
        Script.ShowMessageBox("ERROR", "This script requires an active internet connection.", "OK")
        return
    end

    -- Initial fetch
    local p, err = fetchPayloadList()
    if not p then
        Script.ShowMessageBox("ERROR", err, "OK")
        return
    end

    payloads = p

    -- Main menu loop
    while true do
        local list = buildList()
        local ret = Script.ShowPopupList("MexrlDev Payloads", "", list)

        if ret.Canceled then
            break
        end

        local idx = ret.Selected.Key

        -- Refresh
        if idx == 1 then
            Script.ShowNotification("Refreshing payload list...")
            local p2, err2 = fetchPayloadList()
            if not p2 then
                Script.ShowMessageBox("ERROR", err2, "OK")
                break
            end
            payloads = p2
        -- Payload selection
        elseif idx >= 2 and idx <= #payloads + 1 then
            local filename = payloads[idx - 1]
            downloadAndExecute(filename)
        end
    end
end
