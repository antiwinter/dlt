const fs = require('fs')

let word = { 2: [], 3: [], 4: [] }

fs.readFileSync('./old/words_alpha.txt', 'utf-8')
  .replace(/\r/g, '')
  .split('\n')
  .sort((a, b) => a.length - b.length)
  .forEach(w => {
    if (!word[w.length]) return
    word[w.length].push(w)
  })

word[0] = [
  'å',
  '∫',
  'ç',
  '∂',
  '´',
  'ƒ',
  '©',
  '˙',
  'ˆ',
  '∆',
  '˚',
  '¬',
  'µ',
  '˜',
  'ø',
  'π',
  'œ',
  '®',
  'ß',
  '†',
  '¨',
  '√',
  '∑',
  '≈',
  '¥',
  'Í',
  '□',
  'À',
  '�',
  '℮',
  '╤',
  'ф',
  'Ð',
  'ñ',
  'Ћ',
  'Ç',
  'ƒ',
  'Ё',
  'ê',
  '№',
  'Ä',
  '•',
  'à',
  'ü'
]

word[1] = [
  '[Dwarlorahe]',
  '•0',
  '•3•',
  "'",
  '63636',
  '20',
  '0•',
  "'ƒ",
  '•Ð',
  'ÇÍ',
  "2'",
  '00',
  '2Ð',
  '665G',
  '979',
  'Ä2',
  '•Ç',
  '3À',
  'Ç•',
  'ÇÇ',
  'Ç1T',
  'ƒb',
  'Ç•AG3',
  'Ç•ÇL',
  'Í•1',
  'Í•3',
  'ƒÇ12',
  'ƒÇ•1',
  'ƒÇ•2',
  'Ç1b',
  'Ç•ÇB',
  '№2',
  '№z',
  '•5',
  '22',
  'you’re',
  'À5G',
  'Äà',
  "I'm",
  "'Ç",
  "'Ð"
]

let s = ''
for (let i in word) {
  w = word[i]
  s += `local w${i}={${w
    .slice(0, 500)
    .map(x => {
      return x.match(/\'/) ? `"${x}"` : `'${x}'`
    })
    .join(',')}}`
}
s += 'return w0, w1, w2, w3, w4'

fs.writeFileSync('dict-data.lua', s, 'utf-8')
