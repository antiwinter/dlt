let fs = require('fs')
let text2png = require('text2png')

for (let i = 65; i < 91; i++)
  fs.writeFileSync(
    `./data/${String.fromCharCode(i)}.png`,
    text2png(String.fromCharCode(i), {
      color: 'black',
      font: '14px ARIALN'
    })
  )

for (let i = 97; i < 123; i++)
  fs.writeFileSync(
    `./data/_${String.fromCharCode(i)}.png`,
    text2png(String.fromCharCode(i), {
      color: 'black',
      font: '14px ARIALN'
    })
  )
