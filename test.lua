#!/usr/bin/env lua

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
bit = {
    lshift = function(a, b) return a << b end,
    rshift = function(a, b) return a >> b end,
    band = function(a, b) return a & b end,
    bor = function(a, b) return a | b end
}

function GetDefaultLanguage() return 'Common' end
function GetLocale() return 'enUS' end

function ChatFrame_OnEvent(a, event, msg, user)
    ChatFrame1:AddMessage('[' .. user .. '] says: ' .. msg)
end

function SendChatMessage(msg)
    ChatFrame_OnEvent(nil, 'CHAT_MSG_SAY', msg, 'antiwinter')
end

require 'engineY'
require 'local'
require 'dict'
require 'main'

-- begin test
-- dlt.init()
-- dlt.data = gen()

data = {
    '123', 'The quick brown fox jumps over the lazy dog!!',
    '从前有个山，山里有个洞',
    '这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong. 这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.'
}

for _, v in pairs(data) do
    print('sending', v:len(), v)
    dlt.cli(v)
end

for i = 1, 358 do dlt.cli('test') end
