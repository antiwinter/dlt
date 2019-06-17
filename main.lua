dlt = {
    _event = ChatFrame_OnEvent,
    lang = '',
    locale = '',
    cache = {},

    rgb = function(x, s) return string.format('|c%08x%s|r', x, s) end,

    log = function(msg)
        ChatFrame1:AddMessage(dlt.rgb(0x6666aa00, '[DLT]') ..
                                  dlt.rgb(0xaaaa6600, msg))
    end,

    msg = function(user, msg)
        -- print('dlt-msg', user, msg)
        if not user or not msg then return end
        dlt.log('[' .. user .. ']: ' .. msg)
    end,

    queue = function(user, piece)
        local c = dlt.cache

        -- print('queue', user, piece, piece:sub(1, 2))
        -- start piece, clear previous
        if piece:sub(1, 2) == '\\<' then
            if c[user] then dlt.msg(user, c[user] .. '--') end
            c[user] = ''
            -- print('seg start', c[user])
            piece = piece:sub(3)
        end

        -- ending piece, output result
        if piece:sub(-2) == '\\>' then
            dlt.msg(user, c[user] .. piece:sub(1, -3))
            c[user] = nil
        else
            -- connect w/ previous
            c[user] = c[user] .. piece
            -- print('seg add', c[user])
        end
    end,

    filter = function()
        -- dlt.log('filter event', event, arg1, arg2)
        if event ~= 'CHAT_MSG_SAY' then return end

        local c = dict.from(arg1)
        -- print('filter got', c)
        if c then
            dlt.queue(arg2, c)
        else
            print('triggering default event')
            dlt._event()
        end
    end,

    say = function(msg) SendChatMessage(msg, 'say', dlt.lang) end,

    cli = function(cmd)
        if cmd == '' or cmd == nil then return end
        for _, s in pairs(dict.to(cmd)) do dlt.say(s) end
    end,

    init = function()
        ChatFrame_OnEvent = dlt.filter
        SlashCmdList['dlt'] = dlt.cli
        SLASH_DLT1 = '/dlt'

        dlt.lang = GetDefaultLanguage('player')
        dict.init(dlt.lang == dlt.locale.common and 'alliance' or 'horde')
        dlt.log('inited')
    end
}
