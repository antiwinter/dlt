-- emulated functions
ChatFrame1 = {
    AddMessage = function(self, msg)
        local s = msg:gsub(
                      '|c[0-9,a-z,A-Z][0-9,a-z,A-Z][0-9,a-z,A-Z][0-9,a-z,A-Z][0-9,a-z,A-Z][0-9,a-z,A-Z][0-9,a-z,A-Z][0-9,a-z,A-Z](.-)|r',
                      '%1')
        print(s)
    end
}
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

    ChatFrame_OnEvent()
end

require 'engine16'
require 'main'
require 'local'

-- begin test
dlt.init()

data = {
    '123', 'The quick brown fox jumps over the lazy dog!!',
    '从前有个山，山里有个洞',
    '这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong. 这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.'
}

for _, v in pairs(data) do
    print('sending', v:len(), v)
    dlt.cli(v)
end
