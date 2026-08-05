# Aurora Xbox 360 Lua Scripting Reference
Aurora scripting is based on Lua 5.2.

────────

Global functions

```lua
print(string val)
tprint(table val)
enum(array val)
wait(unsigned val)
tounsigned(int val)
```

────────

Script functions

```lua
Script.SetRefreshListOnExit(bool refreshList)
Script.FileExists(string relativePath)
Script.CreateDirectory(string relativePath)
Script.SetProgress(unsigned val)
Script.SetStatus(string text)
Script.GetProgress(void)
Script.GetStatus(void)
Script.IsCanceled(void)
Script.GetBasePath(void)
Script.ShowNotification(string message, DWORD type)
Script.ShowKeyboard(string title, string prompt, string default, [DWORD flags])
Script.ShowPopupList(string title, string emptyList, table listContent)
Script.ShowPasscode(string title, string prompt, DWORD permissionFlag)
Script.ShowMessageBox(string title, string prompt, string button1text, [string ...])
Script.ShowFilebrowser(string basePath, string selectedItem, [DWORD flags])
```

────────

Library methods

Aurora

```lua
Aurora.GetDashVersion(void)
Aurora.GetSkinVersion(void)
Aurora.GetFSPluginVersion(void)
Aurora.GetIPAddress(void)
Aurora.GetMACAddress(void)
Aurora.GetTime(void)
Aurora.GetDate(void)
Aurora.GetTemperatures(void)
Aurora.GetMemoryInfo(void)
Aurora.GetCurrentSkin(void)
Aurora.GetCurrentLanguage(void)
Aurora.OpenDVDTray(void)
Aurora.CloseDVDTray(void)
Aurora.GetDVDTrayState(void)
Aurora.HasInternetConnection(void)
Aurora.Restart(void)
Aurora.Reboot(void)
Aurora.Shutdown(void)
Aurora.Sha1Hash(string input)
Aurora.Md5Hash(string input)
Aurora.Crc32Hash(string input)
Aurora.Sha1HashFile(string filePath)
Aurora.Md5HashFile(string filePath)
Aurora.Crc32HashFile(string filePath)
```

Content

```lua
Content.GetInfo(DWORD contentId)
Content.SetTitle(DWORD contentId, string title)
Content.SetDescription(DWORD contentId, string description)
Content.SetDeveloper(DWORD contentId, string developer)
Content.SetPublisher(DWORD contentId, string publisher)
Content.SetReleaseDate(DWORD contentId, string releaseDate)
Content.SetAsset(string imagePath, enum assetType, [DWORD screenshotIndex])
Content.FindContent(DWORD titleId, [string searchText])
```

FileSystem

```lua
FileSystem.CopyDirectory(string srcDir, string dstDir, bool overwrite, [function progressRoutine])
FileSystem.MoveDirectory(string srcDir, string dstDir, bool overwrite, [function progressRoutine])
FileSystem.DeleteDirectory(string directory)
FileSystem.CreateDirectory(string directory)
FileSystem.CopyFile(string srcFile, string dstFile, bool overwrite, [function progressRoutine])
FileSystem.MoveFile(string srcFile, string dstFile, bool overwrite, [function progressRoutine])
FileSystem.DeleteFile(string srcFile)
FileSystem.ReadFile(string srcFile)
FileSystem.WriteFile(string srcFile, string buffer)
FileSystem.FileExists(string path)
FileSystem.GetFileSize(string path)
FileSystem.GetAttributes(string path)
FileSystem.GetDrives([boolean contentDrivesOnly])
FileSystem.GetFilesAndDirectories(string path)
FileSystem.GetFiles(string path)
FileSystem.GetDirectories(string path)
FileSystem.Rename(string original, string new)
```

Http

```lua
Http.Get(string url, [string relativeFilePath])
Http.Post(string url, table postvars, [string relativeFilePath])
Http.UrlEncode(string input)
Http.UrlDecode(string input)
```

IniFile

```lua
IniFile.LoadFile(string relativeFilePath)
IniFile.LoadString(string fileData)
```

Userdata methods returned by IniFile.LoadFile / IniFile.LoadString:

```lua
userdata:ReadValue(string section, string key, string default)
userdata:WriteValue(string section, string key, string value)
userdata:GetAllSections(void)
userdata:GetSection(string section)
userdata:GetAllKeys(string section)
```

Kernel

```lua
Kernel.GetVersion(void)
Kernel.GetConsoleTiltState(void)
Kernel.GetCPUKey(void)
Kernel.GetDVDKey(void)
Kernel.GetMotherboardType(void)
Kernel.GetConsoleType(void)
Kernel.GetConsoleId(void)
Kernel.GetSerialNumber(void)
Kernel.GetCPUTempThreshold(void)
Kernel.GetGPUTempThreshold(void)
Kernel.GetEDRAMTempThreshold(void)
Kernel.SetFanSpeed(unsigned fanSpeed)
Kernel.SetCPUTempThreshold(unsigned threshold)
Kernel.SetGPUTempThreshold(unsigned threshold)
Kernel.SetEDRAMTempThreshold(unsigned threshold)
Kernel.RebootSMCRoutine(void)
Kernel.SetDate(unsigned Year, unsigned Month, unsigned Day)
Kernel.SetTime(unsigned Hour, [unsigned Minute, unsigned Second, unsigned Millisecond])
```

Profile

```lua
Profile.GetXUID(unsigned playerIndex)
Profile.GetGamerTag(unsigned playerIndex)
Profile.GetGamerScore(unsigned playerIndex)
Profile.GetTitleAchievement(unsigned playerIndex, unsigned titleId)
```

Settings

```lua
Settings.GetSystem([string, ...])
Settings.GetUser([string, ...])
Settings.SetSystem(string name, string value, [string, string ...])
Settings.SetUser(string name, string value, [string, string ...])
Settings.GetSystemOptions(string name)
Settings.GetUserOptions(string name)
Settings.GetOptions(string name, unsigned settingType)
```

Sql

```lua
Sql.Execute(string query)
Sql.ExecuteFetchRows(string query)
```

Thread

```lua
Thread.Sleep(unsigned)
```

ZipFile

```lua
ZipFile.OpenFile(string relativeFilePath)
```

Userdata methods returned by ZipFile.OpenFile:

```lua
userdata:Extract(string relativeDestDir)
```

GizmoUI

```lua
GizmoUI.CreateInstance(void)
```

Userdata methods returned by GizmoUI.CreateInstance:

```lua
userdata:RegisterCallback(unsigned messageType, function fnCallback)
userdata:RegisterAnimationCallback(string namedFrame, function fnCallback)
userdata:RegisterControl(unsigned objectType, string objectName)
userdata:Dismiss(object key)
userdata:InvokeUI(string basePath, string title, string sceneFile, [string skinFile], [table initData])
userdata:SetCommandText(unsigned commandId, string text)
userdata:SetCommandEnabled(unsigned commandId, bool state)
userdata:SetTimer(unsigned timerId, unsigned timerInterval)
userdata:KillTimer(unsigned timerId)
userdata:PlayTimeline(string startFrame, string initialFrame, string endFrame, bool recurse, bool loop)
userdata:ShowMessageBox(unsigned identifier, string title, string prompt, string button1text, [string ...])
userdata:ShowPasscode(unsigned identifier, string title, string prompt, DWORD permissionFlag)
userdata:ShowKeyboard(unsigned identifier, string title, string prompt, string default, DWORD flags)
userdata:ShowNotification(string message, DWORD type)
```

────────

XUI object hierarchy

XuiObject

```lua
call
typeOf
```

XuiElement : XuiObject

```lua
GetBounds
GetId
PlayTimeline
SetPosition
SetOpacity
SetShow
GetPosition
GetOpacity
IsShown
```

XuiText : XuiElement : XuiObject

```lua
GetText
MeasureText
SetText
```

XuiImage : XuiElement : XuiObject

```lua
GetImagePath
SetImagePath
```

XuiControl : XuiElement : XuiObject

```lua
GetImagePath
IsBackButton
IsEnabled
IsNavButton
PlayVisualRange
SetEnable
SetImagePath
SetText
```

XuiButton : XuiControl : XuiElement : XuiObject

```lua
(none)
```

XuiRadioButton : XuiControl : XuiElement : XuiObject

```lua
(none)
```

XuiRadioGroup : XuiControl : XuiElement : XuiObject

```lua
GetCurSel
SetCurSel
```

XuiLabel : XuiControl : XuiElement : XuiObject

```lua
(none)
```

XuiEdit : XuiControl : XuiElement : XuiObject

```lua
DeleteText
GetCaretPosition
GetLineCount
GetLineIndex
GetMaxVisibleLineCount
GetReadOnly
GetTextLimit
GetTopLine
GetVisibleLineCount
GetVSmoothScrollEnabled
InsertText
SetCaretPosition
SetTextLimit
SetTopLine
```

XuiList : XuiControl : XuiElement : XuiObject

```lua
DeleteItems
GetCurSel
GetItemCheck
GetItemCount
GetMaxVisibleLineCount
GetMaxLinesItemCount
GetText
GetTopItem
GetVisibleItemCount
InsertItems
IsItemChecked
IsItemEnabled
IsItemVisible
SetCurSel
SetCurSelVisible
SetImagePath
SetItemCheck
SetItemEnable
SetText
SetTopItem
```

XuiProgressBar : XuiControl : XuiElement : XuiObject

```lua
GetRange
GetValue
SetRange
SetValue
```

XuiSlider : XuiControl : XuiElement : XuiObject

```lua
GetAccel
GetRange
GetStep
GetValue
SetAccel
SetRange
SetStep
SetValue
```

XuiCheckbox : XuiControl : XuiElement : XuiObject

```lua
IsChecked
SetCheck
```

XuiScene : XuiControl : XuiElement : XuiObject

```lua
(none)
```

XuiTabScene : XuiScene : XuiControl : XuiElement : XuiObject

```lua
CanUserTab
EnableTabbing
GetCount
GetCurrentTab
Goto
GotoNext
GotoPrev
```

────────

## Imported / required module

• require("MenuSystem") — this is a script-local module, not part of the public Aurora API list.

## Aurora APIs

• Aurora.HasInternetConnection()
• Aurora.Restart()

## Script APIs

• Script.ShowMessageBox()
• Script.ShowKeyboard()
• Script.ShowPopupList()
• Script.SetStatus()
• Script.SetProgress()
• Script.GetBasePath()
• Script.ShowNotification()
• Script.SetRefreshListOnExit() is the documented form; the script you pasted calls Script.RefreshListOnExit(refreshRequired), which looks like an older alias or naming mismatch.

## FileSystem APIs

• FileSystem.DeleteDirectory()
• FileSystem.FileExists()
• FileSystem.MoveFile()
• FileSystem.MoveDirectory()
• FileSystem.DeleteFile()

## Http APIs

• Http.Get()

## IniFile APIs

• IniFile.LoadFile()
• IniFile.LoadString()
• :GetAllSections()
• :GetSection()
• :ReadValue()

## ZipFile APIs

• ZipFile.OpenFile()
• :Extract()

## Standard Lua

• print
• pairs
• ipairs
• tonumber
• table.sort
• table.insert
• string.gsub
• string.lower
• string.sub

────────

## Notes

• Public documentation says Aurora scripting is Lua 5.2 based.
• The public API list above is the documented set from the Aurora Scripts repository.
• Some builds or older examples may expose aliases or helper wrappers that are not shown in the current docs.
