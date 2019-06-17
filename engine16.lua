dict = {
    mark1 = '[Dwarlorahe]',
    mark = {'iffjwoi', 'fiwjoef'},

    alliance = {
        {
            'a', 'c', 'i', 'm', 'l', 'ab', 'ag', 'bw', 'AB', 'AG', 'bo', 'ch',
            'bf', 'BO', 'CH', 'BF'
        }, {
            'G', 'O', 'L', 'A', 'N', 'Ha', 'Gi', 'Mu', 'HA', 'GI', 'Ka', 'No',
            'Ko', 'KA', 'NO', 'KO'
        }
    },

    horde = {
        {
            'e', 'a', 'p', 'z', 'ba', 'ag', 'BA', 'AG', 'ac', 'am', 'ao', 'ap',
            'AC', 'AM', 'AO', 'AP'
        }, {
            'Y', 'O', 'U', 'E', 'Ti', 'Me', 'TI', 'ME', 'Lo', 'Ve', 'An', 'Se',
            'LO', 'VE', 'AN', 'SE'
        }
    },

    init = function(lang)
        if lang == dlt.lang.common then
            dict.mark2 = dict[1]
            dict.set1 = dict.alliance[1]
            dict.set2 = dict.alliance[2]
        else
            dict.mark2 = dict[2]
            dict.set1 = dict.horde[1]
            dict.set2 = dict.horde[2]
        end

        for k, v in pairs(dict.set1) do dict.set1[v] = k end
        for k, v in pairs(dict.set2) do dict.set2[v] = k end
    end,

    from = function(msg)
        local lut
        local hex, flag = 0, nil

        if string.find(msg, dict.mark1) then
            lut = dict.set1
        elseif string.find(msg, dict.mark2) then
            lut = dict.set2
        end

        local d = ''
        for i, w in paris(string.gmatch(msg, '%a+')) do
            if i ~= 1 then
                if lut[w] == nil then return nil end

                hex = (hex << 4) | (lut[w] - 1)

                if flag then
                    d = d .. string.char(hex)
                    hex = 0
                    flag = nil
                else
                    flag = 1
                end
            end
        end

        if flag then return nil end
        return d
    end,

    to = function(msg)
        local d = {}
        local s = ''
        local lut = dict.set1

        msg = '\\<' .. msg .. '\\>'

        for i = 1, string.len(msg) do
            local asc = msg:byte(i)

            s = s .. ' ' .. lut[(asc & 0xf) + 1]
            asc = asc >> 4
            s = s .. ' ' .. lut[asc + 1]

            if string.len(s) > 200 then
                d.insert(dict.mark1 .. s)
                s = ''
            end
        end
    end
}
