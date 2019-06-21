local codec = {
    egi = {},
    register = function(self, name, egi) self.egi[name] = egi end,
    dec = function(self, msg)
        local res
        for _, egi in pairs(self.egi) do
            res = egi:dec(msg)
            if res then return res end
        end

        return res
    end,
    enc = function(self, name, msg) return self.egi[name]:enc(msg) end,
    init = function(self, faction, oppositeLang)
        for _, egi in pairs(self.egi) do egi:init(faction, oppositeLang) end
    end
}

dlt.codec = codec
