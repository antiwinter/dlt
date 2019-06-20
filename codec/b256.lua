print('in b256 ???')

dltB256 = {
    mark1 = '[Dwarlorahe] ',
    alliance = {
        lips = {
            'An', 'Ko', 'Lo', 'Lu', 'Me', 'Ne', 'Re', 'Ru', 'Se', 'Ti', 'Va',
            'Ve', 'Ash', 'Bor', 'Bur', 'Far', 'Gol', 'Hir', 'Lon', 'Mod', 'Nud',
            'Ras', 'Ver', 'Vil', 'Vos', 'A', 'E', 'I', 'O', 'U', 'Y', 'Ador',
            'Agol', 'Dana', 'Goth', 'Lars', 'Noth', 'Nuff'
        },
        ears = {
            'G', 'O', 'L', 'A', 'N', 'Ha', 'Gi', 'Mu', 'HA', 'GI', 'Ka', 'No',
            'Ko', 'KA', 'NO', 'KO'
        }
    },

    horde = {
        lips = {
            'An', 'Ko', 'Lo', 'Lu', 'Me', 'Ne', 'Re', 'Ru', 'Se', 'Ti', 'Va',
            'Ve', 'Ash', 'Bor', 'Bur', 'Far', 'Gol', 'Hir', 'Lon', 'Mod', 'Nud',
            'Ras', 'Ver', 'Vil', 'Vos', 'A', 'E', 'I', 'O', 'U', 'Y', 'Ador',
            'Agol', 'Dana', 'Goth', 'Lars', 'Noth', 'Nuff'
        },
        ears = {
            'Y', 'O', 'U', 'E', 'Ti', 'Me', 'TI', 'ME', 'Lo', 'Ve', 'An', 'Se',
            'LO', 'VE', 'AN', 'SE'
        }
    },

    _genTable = function(set)
        local res, i, j, k = {}
        local mask = function(s, m)
            local ms, l, i = '', s:len()

            for i = 1, l do
                ms = ms ..
                         (bit.band(bit.rshift(m, i - 1), 1) == 1 and
                             s:sub(i, i):upper() or s:sub(i, i):lower())
            end

            return ms
        end

        -- round 1: fill 65 ~ 91 with uppercase
        for i = 65, 91 do
            res[i] = set[i - 64]:upper()
            res[set[i - 64]:upper()] = i
        end

        -- round 3: fill 65 ~ 91 with lowercase
        for i = 97, 122 do
            res[i] = set[i - 96]:lower()
            res[set[i - 96]:lower()] = i
        end

        local fill = function(from, to, limit)
            for i = from, to do
                if not res[i] then
                    for j = 1, limit do
                        for k = 0, 15 do
                            local key = mask(set[j], k)
                            if res[key] == nil then
                                res[i] = key
                                res[key] = i
                                break
                            end
                        end

                        if res[i] then break end
                    end
                end
            end
        end

        -- round 3: fill 78, 159 with 2~3 letters
        fill(78, 159, 31)
        -- round 4: fill the rest with what ever
        fill(0, 260, 38)
        return res
    end,

    -- utf8 to utf16
    _u16mark = 259,
    _u16 = function(s)
        local d, l, i = '', s:len()
        local get1 = function(t)
            local r, j = 0
            for j = 7, 0, -1 do
                if bit.band(t, bit.lshift(1, j)) ~= 0 then
                    r = r + 1
                else
                    break
                end
            end

            return r
        end
        local remain, ls, _t = 0, 0, 0

        for i = 1, l do
            local t, n = s:byte(i)
            n = get1(t)

            _t = bit.bor(_t,
                         bit.lshift(bit.band(t, bit.lshift(1, 7 - n) - 1), ls))
            ls = ls + 7 - n

            if n > 1 then
                remain = n - 1
            elseif n > 0 then
                remain = remain - 1
            else
                remain = 0
            end

            if remain == 0 then
                d = d .. string.char(bit.band(_t, 0xff))
                d = d .. string.char(bit.rshift(_t, 8))
                _t = 0
                ls = 0
            end
        end

        return d
    end,

    -- utf16 to utf8
    _utf8 = function(s)
        local ffs = function(t)
            local r, i = 0

            for i = 0, 15 do
                if bit.band(bit.rshift(t, i), 1) == 1 then
                    r = i + 1
                end
            end
            return r
        end

        local l, d, i = s:len(), ''

        if l / 2 ~= bit.rshift(l, 1) then return nil end

        for i = 1, l, 2 do
            local t = bit.bor(s:byte(i), bit.lshift(s:byte(i + 1), 8))
            local n = ffs(t)

            if n < 8 then -- 1 byte
                d = d .. string.char(t)
            elseif n < 12 then -- 2 byte
                d = d .. string.char(0xc0 + t % 32, 0x80 + bit.rshift(t, 5))
            else -- 3 bytes
                d = d ..
                        string.char(0xe0 + t % 16, 0x80 + bit.rshift(t, 4) % 64,
                                    0x80 + bit.rshift(t, 10))
            end
        end

        return d
    end,

    init = function(self, faction, oppositeLang)
        -- print(self, faction, oppositeLang)
        self.mark2 = '[' .. oppositeLang .. '] '
        self.lips = self._genTable(self[faction].lips)
        self.ears = self._genTable(self[faction].lips)
        -- for k, v in pairs(self.lips) do self.lips[v] = k end
        -- for k, v in pairs(self.ears) do self.ears[v] = k end

        print('b256 inited')
        -- for k, v in pairs(self.lips) do
        --     print(string.format('%s=%s', k, v))
        -- end
    end,

    dec = function(self, msg)
        local lut

        if msg:find(self.mark1) then
            lut = self.lips
        elseif msg:find(self.mark2) then
            lut = self.ears
        end

        if not lut then return nil end

        -- remove mark
        msg = msg:gsub('%S+', '', 1)

        local use16
        if msg:find(lut[self._u16mark]) then
            msg = msg:gsub(lut[self._u16mark], '', 1)
            use16 = 1
        end

        local d = ''
        for w in msg:gmatch('%S+') do
            -- print('word', w, lut[w])
            if lut[w] == nil then return nil end
            d = d .. string.char(lut[w])
        end

        if use16 then d = self._utf8(d) end

        if d == '' then return nil end

        local action = 0
        if d:sub(1, 2) == '\\<' then
            action = bit.bor(action, 1)
            d = d:sub(3, -1)
        end

        if d:sub(-2, -1) == '\\>' then
            action = bit.bor(action, 2)
            d = d:sub(1, -3)
        end

        return {action = action, data = d}
    end,

    enc = function(self, msg)
        local d = {}
        local s = ''
        local lut = self.lips
        local use16
        local output = function(s)
            local _s = ''
            _s = _s .. self.mark1
            if use16 then _s = _s .. lut[self._u16mark] .. ' ' end
            _s = _s .. s:sub(1, -2)
            table.insert(d, _s)
        end

        msg = '\\<' .. msg .. '\\>'

        local u16 = self._u16(msg)

        -- -- print('to msg', msg)
        if u16:len() < msg:len() then
            -- print('enc using u16')
            msg = u16
            use16 = 1
        end

        for i = 1, msg:len(), 2 do
            local asc = msg:byte(i)

            s = s .. lut[msg:byte(i)] .. ' '
            if i < msg:len() then
                s = s .. lut[msg:byte(i + 1)] .. ' '
            end

            if s:len() > 200 then
                output(s)
                s = ''
            end
        end

        -- print('d??', d)
        if s ~= '' then output(s) end
        return d
    end
}

print('???')
