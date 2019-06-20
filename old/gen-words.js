const fs = require('fs')

let word = { 2: [], 3: [] }

fs.readFileSync('./words_alpha.txt', 'utf-8')
  .replace(/\r/g, '')
  .split('\n')
  .sort((a, b) => a.length - b.length)
  .forEach(w => {
    if (!word[w.length]) return
    word[w.length].push(w)
  })

console.log(`w2={${word[2].map(x => `'${x}'`).join(',')}}`)
console.log(`w3={${word[3].map(x => `'${x}'`).join(',')}}`)
