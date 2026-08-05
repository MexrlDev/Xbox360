local apis = {

    -- Script
    { "Script.ShowNotification", function() return type(Script.ShowNotification) == "function" end },
    { "Script.ShowPopupList", function() return type(Script.ShowPopupList) == "function" end },
    { "Script.ShowMessageBox", function() return type(Script.ShowMessageBox) == "function" end },
    { "Script.ShowKeyboard", function() return type(Script.ShowKeyboard) == "function" end },
    { "Script.ShowPasscode", function() return type(Script.ShowPasscode) == "function" end },
    { "Script.ShowFilebrowser", function() return type(Script.ShowFilebrowser) == "function" end },
    { "Script.SetStatus", function() return type(Script.SetStatus) == "function" end },
    { "Script.SetProgress", function() return type(Script.SetProgress) == "function" end },
    { "Script.GetProgress", function() return type(Script.GetProgress) == "function" end },
    { "Script.GetStatus", function() return type(Script.GetStatus) == "function" end },
    { "Script.IsCanceled", function() return type(Script.IsCanceled) == "function" end },
    { "Script.GetBasePath", function() return type(Script.GetBasePath) == "function" end },
    { "Script.FileExists", function() return type(Script.FileExists) == "function" end },
    { "Script.CreateDirectory", function() return type(Script.CreateDirectory) == "function" end },
    { "Script.SetRefreshListOnExit", function() return type(Script.SetRefreshListOnExit) == "function" end },
    -- Aurora
    { "Aurora.HasInternetConnection", function() return type(Aurora.HasInternetConnection) == "function" end },
    { "Aurora.Restart", function() return type(Aurora.Restart) == "function" end },
    { "Aurora.Reboot", function() return type(Aurora.Reboot) == "function" end },
    { "Aurora.Shutdown", function() return type(Aurora.Shutdown) == "function" end },
    { "Aurora.GetDashVersion", function() return type(Aurora.GetDashVersion) == "function" end },
    { "Aurora.GetSkinVersion", function() return type(Aurora.GetSkinVersion) == "function" end },
    { "Aurora.GetFSPluginVersion", function() return type(Aurora.GetFSPluginVersion) == "function" end },
    { "Aurora.GetIPAddress", function() return type(Aurora.GetIPAddress) == "function" end },
    { "Aurora.GetMACAddress", function() return type(Aurora.GetMACAddress) == "function" end },
    { "Aurora.GetTime", function() return type(Aurora.GetTime) == "function" end },
    { "Aurora.GetDate", function() return type(Aurora.GetDate) == "function" end },
    { "Aurora.GetTemperatures", function() return type(Aurora.GetTemperatures) == "function" end },
    { "Aurora.GetMemoryInfo", function() return type(Aurora.GetMemoryInfo) == "function" end },
    { "Aurora.GetCurrentSkin", function() return type(Aurora.GetCurrentSkin) == "function" end },
    { "Aurora.GetCurrentLanguage", function() return type(Aurora.GetCurrentLanguage) == "function" end },
    { "Aurora.OpenDVDTray", function() return type(Aurora.OpenDVDTray) == "function" end },
    { "Aurora.CloseDVDTray", function() return type(Aurora.CloseDVDTray) == "function" end },
    { "Aurora.GetDVDTrayState", function() return type(Aurora.GetDVDTrayState) == "function" end },
    { "Aurora.Sha1Hash", function() return type(Aurora.Sha1Hash) == "function" end },
    { "Aurora.Md5Hash", function() return type(Aurora.Md5Hash) == "function" end },
    { "Aurora.Crc32Hash", function() return type(Aurora.Crc32Hash) == "function" end },
    { "Aurora.Sha1HashFile", function() return type(Aurora.Sha1HashFile) == "function" end },
    { "Aurora.Md5HashFile", function() return type(Aurora.Md5HashFile) == "function" end },
    { "Aurora.Crc32HashFile", function() return type(Aurora.Crc32HashFile) == "function" end },

    -- FileSystem
    { "FileSystem.CopyDirectory", function() return type(FileSystem.CopyDirectory) == "function" end },
    { "FileSystem.MoveDirectory", function() return type(FileSystem.MoveDirectory) == "function" end },
    { "FileSystem.DeleteDirectory", function() return type(FileSystem.DeleteDirectory) == "function" end },
    { "FileSystem.CreateDirectory", function() return type(FileSystem.CreateDirectory) == "function" end },
    { "FileSystem.CopyFile", function() return type(FileSystem.CopyFile) == "function" end },
    { "FileSystem.MoveFile", function() return type(FileSystem.MoveFile) == "function" end },
    { "FileSystem.DeleteFile", function() return type(FileSystem.DeleteFile) == "function" end },
    { "FileSystem.ReadFile", function() return type(FileSystem.ReadFile) == "function" end },
    { "FileSystem.WriteFile", function() return type(FileSystem.WriteFile) == "function" end },
    { "FileSystem.FileExists", function() return type(FileSystem.FileExists) == "function" end },
    { "FileSystem.GetFileSize", function() return type(FileSystem.GetFileSize) == "function" end },
    { "FileSystem.GetAttributes", function() return type(FileSystem.GetAttributes) == "function" end },
    { "FileSystem.GetDrives", function() return type(FileSystem.GetDrives) == "function" end },
    { "FileSystem.GetFilesAndDirectories", function() return type(FileSystem.GetFilesAndDirectories) == "function" end },
    { "FileSystem.GetFiles", function() return type(FileSystem.GetFiles) == "function" end },
    { "FileSystem.GetDirectories", function() return type(FileSystem.GetDirectories) == "function" end },
    { "FileSystem.Rename", function() return type(FileSystem.Rename) == "function" end },

    -- Http
    { "Http.Get", function() return type(Http.Get) == "function" end },
    { "Http.Post", function() return type(Http.Post) == "function" end },
    { "Http.UrlEncode", function() return type(Http.UrlEncode) == "function" end },
    { "Http.UrlDecode", function() return type(Http.UrlDecode) == "function" end },

    -- IniFile
    { "IniFile.LoadFile", function() return type(IniFile.LoadFile) == "function" end },
    { "IniFile.LoadString", function() return type(IniFile.LoadString) == "function" end },
    -- IniObject methods (we only check existence of the module)
    { "IniFile (ReadValue/WriteValue/GetAllSections/GetSection/GetAllKeys)", function() return type(IniFile) == "table" end },

    -- Kernel
    { "Kernel.GetVersion", function() return type(Kernel.GetVersion) == "function" end },
    { "Kernel.GetConsoleTiltState", function() return type(Kernel.GetConsoleTiltState) == "function" end },
    { "Kernel.GetCPUKey", function() return type(Kernel.GetCPUKey) == "function" end },
    { "Kernel.GetDVDKey", function() return type(Kernel.GetDVDKey) == "function" end },
    { "Kernel.GetMotherboardType", function() return type(Kernel.GetMotherboardType) == "function" end },
    { "Kernel.GetConsoleType", function() return type(Kernel.GetConsoleType) == "function" end },
    { "Kernel.GetConsoleId", function() return type(Kernel.GetConsoleId) == "function" end },
    { "Kernel.GetSerialNumber", function() return type(Kernel.GetSerialNumber) == "function" end },
    { "Kernel.GetCPUTempThreshold", function() return type(Kernel.GetCPUTempThreshold) == "function" end },
    { "Kernel.GetGPUTempThreshold", function() return type(Kernel.GetGPUTempThreshold) == "function" end },
    { "Kernel.GetEDRAMTempThreshold", function() return type(Kernel.GetEDRAMTempThreshold) == "function" end },
    { "Kernel.SetFanSpeed", function() return type(Kernel.SetFanSpeed) == "function" end },
    { "Kernel.SetCPUTempThreshold", function() return type(Kernel.SetCPUTempThreshold) == "function" end },
    { "Kernel.SetGPUTempThreshold", function() return type(Kernel.SetGPUTempThreshold) == "function" end },
    { "Kernel.SetEDRAMTempThreshold", function() return type(Kernel.SetEDRAMTempThreshold) == "function" end },
    { "Kernel.RebootSMCRoutine", function() return type(Kernel.RebootSMCRoutine) == "function" end },
    { "Kernel.SetDate", function() return type(Kernel.SetDate) == "function" end },
    { "Kernel.SetTime", function() return type(Kernel.SetTime) == "function" end },

    -- Profile
    { "Profile.GetXUID", function() return type(Profile.GetXUID) == "function" end },
    { "Profile.GetGamerTag", function() return type(Profile.GetGamerTag) == "function" end },
    { "Profile.GetGamerScore", function() return type(Profile.GetGamerScore) == "function" end },
    { "Profile.GetTitleAchievement", function() return type(Profile.GetTitleAchievement) == "function" end },

    -- Settings
    { "Settings.GetSystem", function() return type(Settings.GetSystem) == "function" end },
    { "Settings.GetUser", function() return type(Settings.GetUser) == "function" end },
    { "Settings.SetSystem", function() return type(Settings.SetSystem) == "function" end },
    { "Settings.SetUser", function() return type(Settings.SetUser) == "function" end },
    { "Settings.GetSystemOptions", function() return type(Settings.GetSystemOptions) == "function" end },
    { "Settings.GetUserOptions", function() return type(Settings.GetUserOptions) == "function" end },
    { "Settings.GetOptions", function() return type(Settings.GetOptions) == "function" end },

    -- Sql
    { "Sql.Execute", function() return type(Sql.Execute) == "function" end },
    { "Sql.ExecuteFetchRows", function() return type(Sql.ExecuteFetchRows) == "function" end },

    -- Thread
    { "Thread.Sleep", function() return type(Thread.Sleep) == "function" end },

    -- ZipFile
    { "ZipFile.OpenFile", function() return type(ZipFile.OpenFile) == "function" end },

    -- GizmoUI
    { "GizmoUI.CreateInstance", function() return type(GizmoUI.CreateInstance) == "function" end },

    -- Standard Lua globals
    { "print", function() return type(print) == "function" end },
    { "tprint", function() return type(tprint) == "function" end },
    { "enum", function() return type(enum) == "function" end },
    { "wait", function() return type(wait) == "function" end },
    { "tounsigned", function() return type(tounsigned) == "function" end },
}

function main()
    local list = {}
    local available = 0
    local missing = 0

    for _, item in ipairs(apis) do
        local name = item[1]
        local check = item[2]
        local ok = pcall(check)
        local status = "  [OK]"
        if not ok then
            status = "  [MISSING]"
            missing = missing + 1
        else
            available = available + 1
        end
        table.insert(list, name .. status)
    end

    table.insert(list, 1, "---- API Availability (" .. available .. " available, " .. missing .. " missing) ----")
    Script.ShowPopupList("API Dump", "No APIs found", list)
end
