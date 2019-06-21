dlt = {
    _event = ChatFrame_OnEvent,
    lang = '',
    cache = {},
    mode = 'raw',
    codec = nil,
    mask = 1,

    rgb = function(x, s)
        return s
        --  return string.format('|c%08x%s|r', x, s) 
    end,

    log = function(msg)
        ChatFrame1:AddMessage(dlt.rgb(0x6666aa00, '[Ð] ') ..
                                  dlt.rgb(0xaaaa6600, msg))
    end,

    msg = function(user, msg)
        -- print('dlt-msg', user, msg)
        if not user or not msg then return end
        dlt.log('[' .. user .. ']: ' .. msg)
    end,

    queue = function(user, piece)
        local c = dlt.cache
        if not c[user] then c[user] = '' end
        c[user] = c[user] .. piece
    end,

    flush = function(user)
        local c = dlt.cache

        if c[user] and c[user] ~= '' then
            dlt.msg(user, c[user])
            c[user] = nil
        end
    end,

    filter = function(...)
        local _, event, msg, user = ...
        if event == 'CHAT_MSG_SAY' then

            -- for k, v in pairs({...}) do print(k, v) end

            local res = dlt.codec:dec(msg)
            -- print('filter got', res.data, res.action)
            if res then
                if bit.band(res.action, 1) ~= 0 then
                    dlt.flush(user)
                end

                dlt.queue(user, res.data)
                if bit.band(res.action, 2) ~= 0 then
                    dlt.flush(user)
                end

                if dlt.mask and res.data:len() > 2 then return end
            end
        end

        dlt._event(...)
    end,

    say = function(msg) SendChatMessage(msg, 'say', dlt.lang) end,

    cli = function(cmd)
        -- print("in dlt cli", cmd)
        if cmd == '' or cmd == nil then
            return
        elseif cmd == 'mode' then
            dlt.mode = dlt.mode == 'raw' and 'b256' or 'raw'
            dlt.log(string.format('DLT is now in %s mode', dlt.mode))
        elseif cmd == 'mask' then
            dlt.mask = not dlt.mask
            dlt.log(string.format('DLT mask is %s', dlt.mask and 'On' or 'Off'))
        elseif cmd == 'test' then
            print(string.format('testing %d/%d', dict.cursor, dict.n))
            dlt.say(dict.get())
        elseif cmd == 'back' then
            dict.back()
        else
            local _, s
            for _, s in pairs(dlt.codec:enc(dlt.mode, cmd)) do
                dlt.say(s)
            end
        end
    end,

    init = function()
        ChatFrame_OnEvent = dlt.filter
        SlashCmdList['DLT'] = dlt.cli
        SLASH_DLT1 = '/dlt'

        dlt.lang = GetDefaultLanguage('player')
        local faction = 'horde'
        local oppositeLang = dlt.loc.common
        if dlt.lang == dlt.loc.common then
            faction = 'alliance'
            oppositeLang = dlt.loc.orcish
        end

        dlt.codec:init(faction, oppositeLang)
        print('dlt inited')
    end
}
