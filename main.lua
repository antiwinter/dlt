dlt = {
    _event = ChatFrame_OnEvent,
    lang = '',
    cache = {},

    rgb = function(x, s) return string.format('|c%08x%s|r', x, s) end,

    log = function(msg)
        ChatFrame1:AddMessage(dlt.rgb(0x6666aa00, '[DLT] ') ..
                                  dlt.rgb(0xaaaa6600, msg))
    end,

    msg = function(user, msg) dlt.log('[' .. user .. ']: ' .. msg) end,

    queue = function(user, piece)
        local c = dlt.cache

        -- start piece, clear previous
        if string.sub(piece, 2) == '\\<' then
            if c[user] then dlt.msg(user, c[user] .. '--') end
            c[user] = ''
        end

        -- connect w/ previous
        if c[user] then c[user] = c[user] .. piece end

        -- ending piece, output result
        if string.sub(piece, 2) == '\\>' then
            dlt.msg(user, c[user])
            c[user] = nil
        end
    end,

    filter = function()
        if event ~= 'CHAT_MSG_SAY' then return end

        local c = dict.from(arg1)
        if c then
            dlt.queue(arg2, c)
        else
            dlt._event()
        end
    end,

    say = function(msg) SendChatMessage(msg, 'say', dlt.lang) end,

    cli = function(cmd)
        if cmd == '' or cmd == nil then return end
        for s in dict.to(cmd) do dlt.say(s) end
    end,

    init = function()
        ChatFrame_OnEvent = dlt.filter
        SlashCmdList['dlt'] = dlt.cli
        SLASH_DLT1 = '/dlt'

        dlt.lang = GetDefaultLanguage('player')
        dict.init(dlt.lang)
        dlt.log('inited')
    end
}
