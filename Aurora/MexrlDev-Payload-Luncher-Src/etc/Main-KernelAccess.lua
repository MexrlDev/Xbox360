--  Script Metadata
scriptTitle       = "MexrlDev Payloads"
scriptAuthor      = "MexrlDev"
scriptVersion     = 5
scriptDescription = "Browse and execute payloads from MexrlDev's GitHub repo"
scriptPermissions = { "http", "filesystem", "content", "kernel" }


--  Configuration
local BASE_RAW_URL = "https://raw.githubusercontent.com/MexrlDev/Xbox360/refs/heads/main/Aurora/Payloads/"
local STRUCTURE_URL = BASE_RAW_URL .. "structure.txt"
local ITEMS_PER_PAGE = 6

--  Global state
local payloads = {}
local currentPage = 1
local totalPages = 0


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


--  Helper: build the popup list for the current page
function buildPageList()
    local list = {}
    -- Refresh button always first
    table.insert(list, "[ ! ] Refresh List")

    local startIdx = (currentPage - 1) * ITEMS_PER_PAGE + 1
    local endIdx = math.min(startIdx + ITEMS_PER_PAGE - 1, #payloads)

    for i = startIdx, endIdx do
        local name = payloads[i]:gsub("%.lua$", "")
        table.insert(list, name)
    end

    -- Navigation items (wrap-around)
    if totalPages > 1 then
        table.insert(list, "← Previous")
        table.insert(list, "→ Next")
    end

    return list, startIdx
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
    totalPages = math.ceil(#payloads / ITEMS_PER_PAGE)
    currentPage = 1

    -- Main menu loop
    while true do
        local list, startIdx = buildPageList()
        local ret = Script.ShowPopupList("MexrlDev Payloads", "", list)

        if ret.Canceled then
            break
        end

        local idx = ret.Selected.Key

        -- 1) Refresh
        if idx == 1 then
            Script.ShowNotification("Refreshing payload list...")
            local p2, err2 = fetchPayloadList()
            if not p2 then
                Script.ShowMessageBox("ERROR", err2, "OK")
                break
            end
            payloads = p2
            totalPages = math.ceil(#payloads / ITEMS_PER_PAGE)
            currentPage = 1

        -- 2) Payload selection
        elseif idx <= 1 + math.min(ITEMS_PER_PAGE, #payloads - startIdx + 1) then
            local payloadIndex = startIdx + idx - 2
            local filename = payloads[payloadIndex]
            downloadAndExecute(filename)

        -- 3) Previous page (wrap-around)
        elseif list[idx] == "← Previous" then
            if currentPage == 1 then
                currentPage = totalPages
            else
                currentPage = currentPage - 1
            end

        -- 4) Next page (wrap-around)
        elseif list[idx] == "→ Next" then
            if currentPage == totalPages then
                currentPage = 1
            else
                currentPage = currentPage + 1
            end
        end
    end
end
