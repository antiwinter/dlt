function gen()

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
        "Í", "", "□", "À", "�", "℮", "╤", "ф", "Ð", "ñ", "Ћ",
        "Ç", "ƒ", "Ё", "ê", "№", "•0", "•3•", "'", "2", "63636",
        "20", "0•", "3", "Ä", "•", "0", "'ƒ", "•Ð", "ÇÍ", "2'", "00",
        "2Ð", "à", "665G", "979", "Ä2", "•Ç", "3À", "Ç•", "ü",
        "ÇÇ", "Ç1T", "ƒb", "Ç•AG3", "Ç•ÇL", "Í•1", "Í•3",
        "ƒÇ12", "ƒÇ•1", "ƒÇ•2", "Ç1b", "Ç•ÇB", "№2", "№z",
        "•5", "22", "5565255", "you’re", "À5G", "Äà", "I'm", "'Ç", "'Ð"
    }) do p(v) end
    p()

    -- for i = 0, 255 do p(string.char(i)) end
    -- p()

    for i = 10, 35 do for j = 10, 35 do p(g(i) .. g(j)) end end
    p()

    for i = 10, 35 do
        for j = 10, 35 do for k = 10, 35 do p(g(i) .. g(j) .. g(k)) end end
    end
    p()

    return x
end
