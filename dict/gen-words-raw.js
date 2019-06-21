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

word[2] = word[2].slice(0, 500)
word[3] = word[3].slice(0, 500)
word[4] = word[4].slice(0, 500)

word[0] = [
  'å',
  '∫',
  'ç',
  '∂',
  // '´',
  'ƒ',
  // '©',
  '˙',
  'ˆ',
  '∆',
  '˚',
  // '¬',
  // 'µ',
  '˜',
  'ø',
  'π',
  'œ',
  // '®',
  'ß',
  '†',
  // '¨',
  '√',
  '∑',
  '≈',
  // '¥',
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

function genDictData() {
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
}

// genDictData()

function lipsEars(file, name) {
  let ears = []
  let res = {}
  fs.readFileSync(file, 'utf-8')
    .replace(/\r|\n/g, ' ')
    .split(' ')
    .forEach(x => {
      if (x !== '' && x) ears.push(x)
    })

  let n = 0
  let extra = []
  for (let i = 48; i < 58; i++) extra.push(String.fromCharCode(i))
  for (let i = 65; i < 91; i++) extra.push(String.fromCharCode(i))

  extra.forEach(w => {
    if (!res[ears[n]]) res[ears[n]] = []

    res[ears[n]].push(w)
    n++
  })

  for (let i in word) {
    word[i].forEach(w => {
      if (!res[ears[n]]) res[ears[n]] = []

      res[ears[n]].push(w)
      n++
    })
  }

  console.log('lips', n, 'ears', ears.length)

  let s = name + ' = {'
  for (let k in res) {
    let x = res[k].join(' ')
    s += `${k} = ${x.match(/\'/) ? `"${x}"` : `'${x}'`},\n`
  }

  s += '},'

  fs.writeFileSync(`./raw_dict_${name}.lua`, s, 'utf-8')
}

lipsEars('./old/horde_ears_20190620.txt', 'alliance')
lipsEars('./old/alliance_ears_20190620.txt', 'horde')
