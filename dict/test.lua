dict = {
    cursor = 1,
    init = function()
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

        local i, _, v
        for i = 0, 35 do p(g(i)) end
        p()

        for _, v in pairs(w0) do
            p(v)
            p()
        end

        for _, v in pairs(w1) do p(v) end
        p()

        for _, w in pairs(w2) do p(w) end
        p()

        for _, w in pairs(w3) do p(w) end
        p()

        for _, w in pairs(w4) do p(w) end
        p()

        dict.data = x
        dict.n = table.getn(dict.data)
    end,

    get = function()
        local res = dict.data[dict.cursor]
        dict.cursor = dict.cursor + 1
        return res
    end,

    back = function()
        print('cursor', dict.cursor)
        dict.cursor = dict.cursor - (dict.cursor <= 1 and 0 or 1)
    end
}
