#!/usr/bin/env lua

-- special wow lua functions
bit = {
    lshift = function(a, b) return a << b end,
    rshift = function(a, b) return a >> b end,
    band = function(a, b) return a & b end,
    bor = function(a, b) return a | b end
}

table.getn = function(t) return #t end

-- emulated wow API functions
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

function ChatFrame_OnEvent(a, event, msg, user)
    if event == 'CHAT_MSG_SAY' then
        ChatFrame1:AddMessage('[' .. user .. '] says: ' .. msg)
    end
end

function SendChatMessage(msg)
    ChatFrame_OnEvent(nil, 'CHAT_MSG_SAY', msg, 'antiwinter')
end

-- require 'dict/data'
-- require 'dict/test'
require 'dlt'

require 'codec/index'
require 'codec/raw'
require 'codec/b256'

require 'local'
require 'main'

-- begin test
ChatFrame_OnEvent(nil, 'PLAYER_ENTERING_WORLD')

dlt.cli('mask')
data = {
    'hello', 'how are you', 'for this you lose', 'you are an evil korean',
    'may i help you', 'do not kill me', 'fuck you', 'stupid guy', 'ni hao',
    'bu yao sha wo', 'chinese guy', 'run forrest run', 'help me', 'baby', 'sb',
    'nice to meet you', 'sorry', 'quest no kill', 'land lord skil',
    'you bad bull', '1891， 地, crash'
}

for _, v in pairs(data) do
    print(string.format('sending %d bytes: %s', v:len(), v))
    dlt.cli(v)
end

dlt.cli('mode')

data = {
    'The quick brown fox jumps over the lazy dog!!', '123',
    '从前有个山，山里有个洞',
    '这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong. 这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.这条信息没有别的特色，就是非常的长，this message is no special but very loooooooong.',
    '这条信息没有别的特色，就是非常的长，这条信息没有别的特色，就是非常的长，这条信息没有别的特色，就是非常的长，这条信息没有别的特色，就是非常的长，这条信息没有别的特色，就是非常的长，这条信息没有别的特色，就是非常的长，这条信息没有别的特色，就是非常的长，这条信息没有别的特色，就是非常的长'
}

for _, v in pairs(data) do
    print(string.format('sending %d bytes: %s', v:len(), v))
    dlt.cli(v)
end

-- for i = 1, 358 do dlt.cli('test') end
