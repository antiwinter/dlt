const fs = require('fs')
const text2png = require('text2png')
const SSIM = require('image-ssim')
const async = require('async')
const Jimp = require('jimp')
const log = console.log

const PNG = require('pngjs').PNG

function loadPng(file1, file2, done) {
  var images = []

  function loaded(img) {
    images.push(img)

    if (images.length === 2) {
      done(images)
    }
  }

  function load(filePath, done) {
    fs.createReadStream(filePath)
      .pipe(new PNG())
      .on('parsed', function() {
        done({
          data: this.data,
          width: this.width,
          height: this.height,
          channels: 4
        })
      })
  }

  load(file1, loaded)
  load(file2, loaded)
}

log('gen images...')
let keys = []
let pairs = []
function p(c) {
  return `./data/${c >= 'a' ? '_' + c : c}.png`
}
function gen(start) {
  for (let i = start; i < start + 26; i++) {
    let c = String.fromCharCode(i)
    keys.push(c)
    fs.writeFileSync(
      p(c),
      text2png(c, {
        color: 'black',
        font: '14px ARIALN'
      })
    )
  }
}

gen(65)
gen(97)

// log(keys)
keys.forEach(k1 => {
  keys.forEach(k2 => pairs.push({ k1, k2 }))
})

// log(pairs)

async.eachLimit(
  keys,
  1,
  (k, cb) => {
    log('resizing...', k)
    Jimp.read(p(k), (err, png) => {
      if (err) throw err
      png.cover(20, 20).write(p(k)) // save
      cb()
    })
  },
  () => {
    async.eachLimit(pairs, 1, (d, _cb) => {
      loadPng(p(d.k1), p(d.k2), img => {
        d.ssim = SSIM.compare(img[0], img[1])
        log('comparing...', d.k1, d.k2, d.ssim)
        _cb()
      })
    })

    log(pairs)
  }
)
