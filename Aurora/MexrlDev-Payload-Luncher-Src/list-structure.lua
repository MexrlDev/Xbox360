-- Fetches and parses the payload list from GitHub.
local BASE_RAW_URL = "https://raw.githubusercontent.com/MexrlDev/Xbox360/refs/heads/main/Aurora/Payloads/"
local STRUCTURE_FILE = "structure.txt"

local M = {}

-- Returns a table of filenames (strings), or nil + error message
function M.fetchPayloadList()
    local url = BASE_RAW_URL .. STRUCTURE_FILE
    Script.SetStatus("Fetching payload list...")
    Script.SetProgress(0)
    local http = Http.Get(url)
    if not http.Success then
        return nil, "Failed to download structure.txt"
    end
    Script.SetProgress(100)

    local payloads = {}
    for line in http.OutputData:gmatch("[^\r\n]+") do
        line = line:match("^%s*(.-)%s*$")
        if line ~= "" then
            table.insert(payloads, line)
        end
    end

    if #payloads == 0 then
        return nil, "No payloads found"
    end

    return payloads
end

-- Returns the full raw URL for a given payload filename
function M.getPayloadURL(filename)
    return BASE_RAW_URL .. filename
end

return M