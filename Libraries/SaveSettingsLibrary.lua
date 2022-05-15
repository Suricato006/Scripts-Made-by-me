local Library = {}
if not writefile or not readfile or not isfile or not delfile then
    return Library
end

local HttpService = game:GetService("HttpService")
Library.SaveSettings = function(FileName, Table)
    writefile(FileName, HttpService:JSONEncode(Table))
end

Library.LoadSettings = function(FileName)
    if not isfile(FileName) then
        return {}
    end
    return HttpService:JSONDecode(readfile(FileName))
end

Library.DeleteSettings = function(FileName)
    delfile(FileName)
end

return Library