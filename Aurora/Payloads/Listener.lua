local WATCH_DIR = "RemotePayloads\\"
local BASE = Script.GetBasePath()
local FULL_DIR = BASE .. WATCH_DIR
local FTP_PORT = "21"   -- Aurora FTP default port

function main()
    -- Get Xbox IP
    local ip = "unknown"
    pcall(function()
        ip = Aurora.GetIPAddress()
    end)

    -- Show listening info
    Script.ShowMessageBox(
        "Listener Active",
        "FTP Payload Listener\n\nIP: " .. ip .. "\nPort: " .. FTP_PORT ..
        "\n\nSend .lua files via FTP to:\n" .. FULL_DIR,
        "OK"
    )
    Script.SetStatus("Listener running - " .. ip .. ":" .. FTP_PORT)

    -- Create watch directory if missing
    if not FileSystem.FileExists(FULL_DIR) then
        FileSystem.CreateDirectory(FULL_DIR)
    end

    local known = {}
    -- initial scan to mark existing files as known
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
                    Script.ShowNotification("New payload: " .. f)
                    local path = FULL_DIR .. f
                    local content = FileSystem.ReadFile(path)
                    if content then
                        main = nil  -- clear any previous main
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
                        else
                            Script.ShowNotification("Invalid Lua: " .. err)
                        end
                    end
                    -- delete file after processing
                    FileSystem.DeleteFile(path)
                end
            end
            -- refresh known list
            for _, f in ipairs(files) do
                known[f] = true
            end
        end

        -- small delay to reduce CPU usage
        for _ = 1, 1000000 do end
    end
end
