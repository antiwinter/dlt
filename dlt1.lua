function log(msg)
    ChatFrame1:AddMessage('|c0000FF00[DLT]|r |c002571E2' .. msg .. '|r')
    if DLT_OnCombatLog then
        ChatFrame2:AddMessage('|c0000FF00[DLT]|r |c002571E2' .. msg .. '|r')
    end
end

function dltInit()
    _event = ChatFrame_OnEvent
    ChatFrame_OnEvent = dltFilter

    SlashCmdList['DLT'] = dltCli
    SLASH_DLT1 = '/dlt'
    log('inited')
end

parser = {
    cache = {},
    push = function(self, user, msg)
        local c = self.collect(msg)
        if c then
            self.cache[user].push(c)
            return true
        end
        return false
    end
}

function dltFilter()
    local isDlt = parser:push(arg2, arg1)
    if not isDlt then _event(event) end
end

function dltCli(cmd)
    if cmd == '' or cmd == nil then return end
    dltSendMessage(cmd)
end
