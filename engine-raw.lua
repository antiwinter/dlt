dict = {
    rset = {},
    alliance = {
        A = 'Í',
        B = '□',
        K = 'À',
        V = '•',
        G = '℮',
        H = '╤',
        l = 'ф',
        L = 'Ð',
        m = 'ü',
        N = 'Ћ',
        R = 'Ç',
        S = 'ƒ',
        T = 'Ё',
        v = 'ê',
        W = '№',
        GO = '•0',
        AND = '•3•',
        O = 'Y',
        E = 'Z',
        REGEN = '63636',
        AN = 'YX',
        NO = '0•',
        Y = 'X',
        M = 'Ä',
        U = 'P',
        NU = "'ƒ",
        WI = '•Ð',
        TH = 'ÇÍ',
        KO = 'ZG',
        RE = 'YY',
        VI = '2Ð',
        r = 'à',
        FAR = 'BMR',
        HI = 'Ä2',
        ME = 'YG',
        MO = '3À',
        ER = 'Ç•',
        AD = 'ÇÇ',
        GOT = 'À5G',
        Fa = 'ƒb',
        MAN = 'Í•1',
        ROT = 'Í•3',
        SKIL = 'ƒÇ12',
        RUFT = 'ƒÇ•1',
        LAND = 'ƒÇ•2',
        THo = 'Ç1b',
        LORD = 'Ç•ÇB',
        UD = '№2',
        Od = 'Äà',
        DA = '•5',
        TI = 'ZY',
        RAs = "I'm",
        AS = "'Ç",
        BO = "'Ð",
        LO = 'ZP',
        VE = 'YW',
        SE = 'ZX',
        NE = 'ZZ',
        RU = 'ZW',
        VA = 'YM',
        LU = 'ZM',
        GOL = 'BMZ',
        BUR = 'BLX',
        NUD = 'BMS',
        RAS = 'BLT',
        LON = 'BND',
        VIL = 'BNC',
        HIR = 'BMQ',
        VER = 'BNF',
        BOR = 'BMJ',
        MOD = 'BMI',
        WOS = 'BNB',
        ASH = 'BML'
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

    match = function(s)
        local d = 100
        local res = ''
        for k, v in pairs(dict.set) do
            local _d = k:levenshtein(s)
            if _d < d then
                res = k
                d = _d
            end
        end

        return res, d
    end,

    tr = function(seg)
        local s0, n0 = dict.match(seg)
        local s = seg:sub(1, 3)
        local s1, s2, s3 = s:sub(1, 1), s:sub(2, 2), s:sub(3, 3)
        local ss1, ss2 = s:sub(1, 2), s:sub(2, 3)

        if (n0 < 0.2) then return s0, '' end

        local n, n1, n2, n3, nn1, nn2
        s, n = dict.match(s)
        s1, n1 = dict.match(s1)
        s2, n2 = dict.match(s2)
        s3, n3 = dict.match(s3)
        ss1, nn1 = dict.match(ss1)
        ss2, nn2 = dict.match(ss2)

        if n1 + n2 + n3 < n then
            s = s1 .. ' ' .. s2 .. ' ' .. s3
            n = n1 + n2 + n3
        end

        if nn1 + n3 < n then
            s = ss1 .. ' ' .. s3
            n = nn1 + n3
        end

        if n1 + nn2 < n then
            s = s1 .. ' ' .. ss2
            n = n1 + nn2
        end

        -- print(s, 'distance', n)
        return s, seg:sub(4, -1)
    end,

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
                v, s = dict.tr(s)
                d = d .. v .. ' ' -- connect segments
            until s == ''

            _d = _d .. d -- connect words

            if _d:len() > 200 then
                table.insert(res, _d:sub(1, -2))
                _d = ''
            end
        end

        if _d ~= '' then table.insert(res, _d) end
        return res
    end

}
