local dict = {
    rset = {},
    a2h = {
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
        RUFF = '665G',
        FAR = 'BMR',
        HI = 'Ä2',
        ME = 'YG',
        MO = '3À',
        ER = 'Ç•',
        AD = 'ÇÇ',
        GOT = 'À5G',
        Fa = 'ƒb',
        HAMER = 'Ç•AG3',
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
        FORTHIS = '5565255',
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
