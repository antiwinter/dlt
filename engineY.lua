dict = {
    mark1 = '[Dwarlorahe]',

    alliance = {
        mark2 = 'fiofwof',
        tongue = {
            'a', 'c', 'i', 'm', 'l', 'ab', 'ag', 'bw', 'AB', 'AG', 'bo', 'ch',
            'bf', 'BO', 'CH', 'BF'
        },
        ear = {
            'G', 'O', 'L', 'A', 'N', 'Ha', 'Gi', 'Mu', 'HA', 'GI', 'Ka', 'No',
            'Ko', 'KA', 'NO', 'KO'
        }
    },

    horde = {
        mark2 = 'fwiewf',
        tongue = {
            'e', 'a', 'p', 'z', 'ba', 'ag', 'BA', 'AG', 'ac', 'am', 'ao', 'ap',
            'AC', 'AM', 'AO', 'AP'
        },
        ear = {
            'Y', 'O', 'U', 'E', 'Ti', 'Me', 'TI', 'ME', 'Lo', 'Ve', 'An', 'Se',
            'LO', 'VE', 'AN', 'SE'
        }
    },

    init = function(faction)
        print('in dict', faction)
        dict.mark2 = dict[faction].mark2
        dict.set1 = dict[faction].tongue
        dict.set2 = dict[faction].ear

        for k, v in pairs(dict.set1) do dict.set1[v] = k end
        for k, v in pairs(dict.set2) do dict.set2[v] = k end
    end,

    from = function(msg)
        local lut = nil
        local hex, flag = 0, nil

        -- print('hear msg', msg)
        -- print('finding', dict.mark1)

        -- _1, _2 = msg:find(dict.mark1)
        -- print('_1_2', _1, _2)

        if msg:find(dict.mark1) then
            -- print('xxx')
            lut = dict.set1
        elseif msg:find(dict.mark2) then
            lut = dict.set2
        end

        -- print('dict', dict.mark2, dict.set1, dict.set2)

        if not lut then return nil end
        -- print('lut found', lut)

        local d = ''

        -- print('from msg', msg)
        local skip = nil
        for w in msg:gmatch('[%a%w]+') do
            if not skip then
                skip = 1
            else
                -- print('word', w, lut[w])
                if lut[w] == nil then return nil end

                hex = bit.bor(bit.lshift(hex, 4), (lut[w] - 1))

                if flag then
                    d = d .. string.char(hex)
                    -- print('tr w', string.format('%02x', hex), string.char(hex))
                    hex = 0
                    flag = nil
                else
                    flag = 1
                end
            end
        end

        -- print('translate to', d, flag)

        if flag or d == '' then return nil end
        return d
    end,

    to = function(msg)
        local d = {}
        local s = ''
        local lut = dict.set1

        msg = '\\<' .. msg .. '\\>'

        -- -- print('to msg', msg)

        for i = 1, msg:len() do
            local asc = msg:byte(i)

            -- -- print('sending', msg:sub(i, i), string.format('%02x', asc))

            s = s .. ' ' .. lut[bit.rshift(asc, 4) + 1]
            s = s .. ' ' .. lut[bit.band(asc, 0xf) + 1]

            if s:len() > 200 then
                table.insert(d, dict.mark1 .. s)
                s = ''
            end
        end

        -- print('d??', d)
        if s ~= '' then table.insert(d, dict.mark1 .. s) end

        return d
    end
}

print('in engine-16, dict is', dict)
