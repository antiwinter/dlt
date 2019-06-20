local codec = {
    mark1 = '[Dwarlorahe]',
    alliance = {
        lips = {
            'E', 'A', 'P', 'Z', 'Ba', 'Ag', 'BA', 'AG', 'Ac', 'Am', 'Ao', 'Ap',
            'AC', 'AM', 'AO', 'AP'
        },
        ears = {
            'G', 'O', 'L', 'A', 'N', 'Ha', 'Gi', 'Mu', 'HA', 'GI', 'Ka', 'No',
            'Ko', 'KA', 'NO', 'KO'
        }
    },

    horde = {
        lips = {
            'A', 'C', 'I', 'M', 'L', 'Ab', 'Ag', 'Bw', 'AB', 'AG', 'Bo', 'Ch',
            'Bf', 'BO', 'CH', 'BF'
        },
        ears = {
            'Y', 'O', 'U', 'E', 'Ti', 'Me', 'TI', 'ME', 'Lo', 'Ve', 'An', 'Se',
            'LO', 'VE', 'AN', 'SE'
        }
    },

    init = function(self, faction, oppositeLang)
        print(self, faction, oppositeLang)
        self.mark2 = '[' .. oppositeLang .. ']'
        self.lips = self[faction].lips
        self.ears = self[faction].ears
        for k, v in pairs(self.lips) do self.lips[v] = k end
        for k, v in pairs(self.ears) do self.ears[v] = k end
        print('b16 inited')
    end,

    dec = function(self, msg)
        local lut
        local hex, flag = 0, nil

        if msg:find(self.mark1) then
            lut = self.lips
        elseif msg:find(self.mark2) then
            lut = self.ears
        end

        if not lut then return nil end

        local d = ''

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

        local action = 0
        if d:sub(1, 2) == '\\<' then
            action = bit.bor(action, 1)
            d = d:sub(3, -1)
        end

        if d:sub(-2, -1) == '\\>' then
            action = bit.bor(action, 2)
            d = d:sub(1, -3)
        end

        -- print('action', action)

        return {action = action, data = d}
    end,

    enc = function(self, msg)
        local d = {}
        local s = ''
        local lut = self.lips

        msg = '\\<' .. msg .. '\\>'

        -- -- print('to msg', msg)

        for i = 1, msg:len() do
            local asc = msg:byte(i)

            -- -- print('sending', msg:sub(i, i), string.format('%02x', asc))

            s = s .. ' ' .. lut[bit.rshift(asc, 4) + 1]
            s = s .. ' ' .. lut[bit.band(asc, 0xf) + 1]

            if s:len() > 200 then
                table.insert(d, self.mark1 .. s)
                s = ''
            end
        end

        -- print('d??', d)
        if s ~= '' then table.insert(d, self.mark1 .. s) end

        return d
    end
}

print('in codec-b16, codec is', codec)
return codec
