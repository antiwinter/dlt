local dict = {
    rset = {},
    alliance = {
        A = 'Í',
        B = '□',
        C = 'À',
        E = 'b',
        F = '',
        G = '℮',
        H = '╤',
        I = 'ф',
        K = 'À',
        L = 'Ð',
        M = 'ñ',
        N = 'Ћ',
        O = 'm',
        R = 'Ç',
        S = 'ƒ',
        T = 'Ё',
        U = 'p',
        V = 'ê',
        W = '№',
        Y = 'd',
        AN = '20'
    },
    horde = {
        A = 'Í',
        B = '□',
        C = 'À',
        E = 'b',
        F = '',
        G = '℮',
        H = '╤',
        I = 'ф',
        K = 'À',
        L = 'Ð',
        M = 'ñ',
        N = 'Ћ',
        O = 'm',
        R = 'Ç',
        S = 'ƒ',
        T = 'Ё',
        U = 'p',
        V = 'ê',
        W = '№',
        Y = 'd',
        AN = '20'
    },

    similiarity = function(a, b)
        if not a or not b then return 0.5 end
        if a:lower() == b:lower() then return 1 end
        
    end,

    match = function(seg) end,

    init = function(faction)
        dict.set = dict[faction]
        for k, v in pairs(dict.set) do dict.rset[v] = k end
    end,

    from = function(msg)
        local d = ''
        for w in msg:gmatch('%S+') do
            if dict.rset[w] == nil then return nil end
            d = d .. ' ' .. dict.rset[w]
        end

        return d == '' and nil or d
    end,

    to = function(msg)
        local res = {}
        local _d = ''
        for w in msg:gmatch('%S+') do
            local v, s, d = nil, w, ''
            repeat
                v, s = dict.match(s)
                d = d .. v .. ' ' -- connect segments
            until s == ''

            _d = _d .. d -- connect words

            if _d:len() > 200 then
                table.insert(res, _d:sub(1, -2))
                _d = ''
            end
        end

        return res
    end

}
