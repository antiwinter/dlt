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
            -- print('triggering default event')
            dlt._event()
        end
    end,

    say = function(msg) SendChatMessage(msg, 'say', dlt.lang) end,

    test = function()
        local g = function(n)
            local z = 0
            if n < 10 then
                z = 48 + n
            elseif n < 36 then
                z = 65 + n - 10
            else
                z = 97 + n - 36
            end
            return string.char(z)
        end

        local x = {}
        local s = ''

        local p = function(a)
            if not a then
                if s ~= '' then
                    table.insert(x, s)
                    s = ''
                end
                return
            end

            s = s .. ' ' .. a
            if s:len() > 200 then
                table.insert(x, s)
                s = ''
            end
        end

        for _, v in pairs({
            'Í', '□', 'À', 'b', '', '℮', '╤', 'ф', 'À', 'Ð', 'ñ',
            'Ћ', 'm', 'Ç', 'ƒ', 'Ё', 'p', 'ê', '№', 'd'
        }) do p(v) end
        p()

        for i = 0, 255 do p(string.char(i)) end
        p()

        for i = 0, 61 do for j = 0, 61 do p(g(i) .. g(j)) end end
        p()

        for i = 0, 61 do
            for j = 0, 61 do
                for k = 0, 61 do p(g(i) .. g(j) .. g(k)) end
            end
        end
        p()

        for _, v in pairs(x) do dlt.say(v) end
    end,

    cli = function(cmd)
        if cmd == '' or cmd == nil then
            return
        elseif cmd == 'test' then
            dlt.test()
        else
            for _, s in pairs(dict.to(cmd)) do dlt.say(s) end
        end
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
