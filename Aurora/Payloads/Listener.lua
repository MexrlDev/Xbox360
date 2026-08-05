-- Waits for new .lua files in RemotePayloads/ and executes them.

local WATCH_DIR = "RemotePayloads\\"
local BASE = Script.GetBasePath()
local FULL_DIR = BASE .. WATCH_DIR

function main()
    if not FileSystem.FileExists(FULL_DIR) then
        FileSystem.CreateDirectory(FULL_DIR)
    end
    Script.SetStatus("FTP watcher running")
    Script.ShowNotification("FTP watcher started - listening for payloads")

    local known = {}
    -- initial scan
    local files = FileSystem.GetFiles(FULL_DIR)
    if files then
        for _, f in ipairs(files) do
            known[f] = true
        end
    end

    while true do
        files = FileSystem.GetFiles(FULL_DIR)
        if files then
            for _, f in ipairs(files) do
                if not known[f] and f:match("%.lua$") then
                    Script.ShowNotification("New payload detected: " .. f)
                    local path = FULL_DIR .. f
                    local content = FileSystem.ReadFile(path)
                    if content then
                        main = nil
                        local chunk, err = load(content, f)
                        if chunk then
                            local ok, runErr = pcall(chunk)
                            if ok and type(main) == "function" then
                                pcall(main)
                            end
                            if not ok then
                                Script.ShowNotification("Error: " .. tostring(runErr))
                            else
                                Script.ShowNotification(f .. " executed")
                            end
                            FileSystem.DeleteFile(path)  -- remove after execution
                        else
                            Script.ShowNotification("Invalid Lua: " .. err)
                            FileSystem.DeleteFile(path)
                        end
                    end
                end
            end
            -- refresh known list
            for _, f in ipairs(files) do
                known[f] = true
            end
        end

        -- tiny delay to avoid hammering the disk
        for _ = 1, 1000000 do end
    end
end
