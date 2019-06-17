-- emulated functions
ChatFrame1 = {AddMessage = function(self, msg) print(msg) end}
SlashCmdList = {}

function GetDefaultLanguage() return 'Common' end
function GetLocale() return 'enUS' end

function ChatFrame_OnEvent()
    ChatFrame1:AddMessage('[' .. arg2 .. '] says: ' .. arg1)
end

function SendChatMessage(msg)
    event = 'CHAT_MSG_SAY'
    arg1 = msg
    arg2 = 'antiwinter'
end

require 'engine16'
require 'main'
require 'local'

dlt.init()

dlt.say('123')