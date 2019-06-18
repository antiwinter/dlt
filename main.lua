g9999 = 0
g9998 = 1
dlt = {
    _event = ChatFrame_OnEvent,
    lang = '',
    cache = {},

    rgb = function(x, s)
        return s
        --  return string.format('|c%08x%s|r', x, s) 
    end,

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

    filter = function(...)

        local _, event, msg, user = ...
        if event == 'CHAT_MSG_SAY' then

            -- for k, v in pairs({...}) do print(k, v) end

            local c = dict.from(msg)
            -- print('filter got', c)
            if c then
                dlt.queue(user, c)
                -- return
            end
        end

        dlt._event(...)

    end,

    say = function(msg) SendChatMessage(msg, 'say', dlt.lang) end,

    test = function()
        local n
        if _VERSION == 'Lua 5.1' then
            print("xx")
            n = table.getn(dlt.data)
        else
            print("yy")

            -- n = #dlt.data
        end
        print('nnn?', n)
        print(g9998, n)
        if g9998 > n then return end

        -- print(dlt.data[g9998])
        dlt.say(dlt.data[g9998])
        g9998 = g9998 + 1
    end,

    cli = function(cmd)
        -- print("in dlt cli", cmd)
        if cmd == '' or cmd == nil then
            return
        elseif cmd == 'test' then
            print('in test')
            dlt.test()
        elseif cmd == 'back' then
            g9998 = g9998 - 1
            print('mv g9998 backward', g9998)
        else
            for _, s in pairs(dict.to(cmd)) do dlt.say(s) end
        end
    end,

    init = function()
        print('in init')
        ChatFrame_OnEvent = dlt.filter
        print('in 1')

        SlashCmdList['DLT'] = dlt.cli
        SLASH_DLT1 = '/dlt'
        print('in 2')

        dlt.lang = GetDefaultLanguage('player')
        print('in 3', dlt.lang, dltLocal.common)
        print('dict is', dict)
        dict.init(dlt.lang == dltLocal.common and 'alliance' or 'horde')
        print('in 4')

        dlt.log('inited')

        print('inited')
    end
}

print('in')

print('0x36 >> 4 is', bit.rshift(0x36, 4))

print('version is', _VERSION)

dlt.init()
dlt.data = gen()
