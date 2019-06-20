let raw = `A, E, I, O, U, Y, An, Ko, Lo, Lu, Me, Ne, Re, Ru, Se, Ti, Va, Ve, Ash, Bor, Bur, Far, Gol, Hir, Lon, Mod, Nud, Ras, Ver, Vil, Vos,
Ador, Agol, Dana, Goth, Lars, Noth, Nuff, Odes, Ruff, Thor, Uden, Veld, Vohl, Vrum,
Aesire, Aziris, Daegil, Danieb, Ealdor, Engoth, Goibon, Mandos, Nevren, Rogesh, Rothas, Ruftos, Skilde, Valesh, Vandar, Waldir,
Andovis, Ewiddan, Faergas, Forthis, Kaelsig, Koshvel, Lithtos, Nandige, Nostyec, Novaedi, Sturume, Vassild,
Aldonoth, Cynegold, Endirvis, Hamerung, Landowar, Lordaere, Methrine, Ruftvess, Thorniss,
Aetwinter, Danagarde, Eloderung, Firalaine, Gloinador, Gothalgos, Regenthor, Udenmajis, Vandarwos, Veldbarad,
Aelgestron, Cynewalden, Danavandar, Dyrstigost, Falhedring, Vastrungen,
Agolandovis, Bornevalesh, Dornevalesh, Farlandowar, Forthasador, Thorlithtos, Vassildador, Wershaesire,
Golveldbarad, Mandosdaegil, Nevrenrothas, Waldirskilde`

let dict = raw.replace(/\n| /g, '').split(',')

console.log(dict.length, 'keys', 6 * 2 + 12 * 4 + 13 * 8)
