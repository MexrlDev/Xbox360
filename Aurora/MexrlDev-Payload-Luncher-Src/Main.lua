--  Script Metadata
scriptTitle       = "MexrlDev Payloads"
scriptAuthor      = "MexrlDev"
scriptVersion     = 4
scriptDescription = "Browse and execute payloads from MexrlDev's GitHub repo"
scriptPermissions = { "http", "filesystem" }


--  Payload list module
local listModule = require("list-structure")

-- How many payloads to show per page
local ITEMS_PER_PAGE = 6

-- Global state
local payloads = {}
local currentPage = 1
local totalPages = 0

--  Helper: build the popup list for the current page
function buildPageList()
    local list = {}
    -- Refresh button always first
    table.insert(list, "[ ! ] Refresh List")

    -- Calculate payload slice for this page
    local startIdx = (currentPage - 1) * ITEMS_PER_PAGE + 1
    local endIdx = math.min(startIdx + ITEMS_PER_PAGE - 1, #payloads)

    for i = startIdx, endIdx do
        local name = payloads[i]:gsub("%.lua$", "")
        table.insert(list, name)
    end

    -- Navigation items
    if totalPages > 1 then
        table.insert(list, "← Previous")
        table.insert(list, "→ Next")
    end

    return list, startIdx
end

--  Execute a payload
function downloadAndExecute(filename)
    local url = listModule.getPayloadURL(filename)

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
    local success, err = refreshPayloadList()
    if not success then
        Script.ShowMessageBox("ERROR", err, "OK")
        return
    end

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
            local ok, errMsg = refreshPayloadList()
            if not ok then
                Script.ShowMessageBox("ERROR", errMsg, "OK")
                break
            end
            -- stay on page 1 after refresh
            currentPage = 1
        -- 2) Payload selection
        elseif idx <= 1 + (math.min(ITEMS_PER_PAGE, #payloads - startIdx + 1)) then
            local payloadIndex = startIdx + idx - 2
            local filename = payloads[payloadIndex]
            local ok = downloadAndExecute(filename)
            if not ok then
                Script.ShowMessageBox("ERROR", "Failed to execute " .. filename, "OK")
            end
        -- 3) Previous page
        elseif list[idx] == "← Previous" then
            if currentPage == 1 then
                currentPage = totalPages
            else
                currentPage = currentPage - 1
            end
        -- 4) Next page
        elseif list[idx] == "→ Next" then
            if currentPage == totalPages then
                currentPage = 1
            else
                currentPage = currentPage + 1
            end
        end
    end
end

--  Fetch / re‑fetch the payload list from GitHub
function refreshPayloadList()
    local p, err = listModule.fetchPayloadList()
    if not p then
        return false, err
    end
    payloads = p
    totalPages = math.ceil(#payloads / ITEMS_PER_PAGE)
    currentPage = 1
    return true
end
