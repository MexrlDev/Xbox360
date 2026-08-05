-- Remote Payload Listener (HTTP polling)

local TARGET_URL = "http://192.168.12.4:9068/payload.lua"
local POLL_INTERVAL = 3000
local lastHash = ""

function main()
    if not Aurora.HasInternetConnection() then
        Script.ShowMessageBox("ERROR", "No network connection.", "OK")
        return
    end

    Script.ShowNotification("Listener started – polling " .. TARGET_URL)

    while true do
        local http = Http.Get(TARGET_URL)
        if http.Success and http.OutputData and #http.OutputData > 0 then
            local newHash = Aurora.Md5Hash(http.OutputData)
            if newHash ~= lastHash then
                lastHash = newHash
                Script.ShowNotification("New payload received, executing...")

                -- Execute the downloaded code
                main = nil
                local chunk, err = load(http.OutputData, "remote_payload")
                if chunk then
                    local ok, runErr = pcall(chunk)
                    if ok and type(main) == "function" then
                        pcall(main)
                    end
                    if not ok then
                        Script.ShowNotification("Execution error: " .. tostring(runErr))
                    end
                else
                    Script.ShowNotification("Invalid Lua: " .. err)
                end
            end
        else
            Script.ShowNotification("Polling... server not reachable")
        end

        -- Wait before next poll
        local waitUntil = os.time() + (POLL_INTERVAL / 1000)
        while os.time() < waitUntil do end
    end
end
