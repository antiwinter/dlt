local loc, data = GetLocale()

if (loc == 'zhCN') then
    data = {common = '通用语', orcish = '兽人语'}
else
    data = {common = 'Common', orcish = 'Orcish'}
end

dlt.loc = data
