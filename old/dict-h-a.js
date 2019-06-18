let tongue = `1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54
58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105
109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146
a b c d e f g h i j k l m n o p q r s t u v w x y z
`

let ear = `a g l l a n l n g ka ha ag ha ag ha ag no ag ha ag ko ka ko ka ko ka mu ka ko il no gi no gi no gi ha gi no gi mu il mu il mu il ko il mu ko ag ha ag ha
ha ag ha ka ko ka ko ka ko il ko ka il no gi no gi no gi ha gi no no il mu il mu il mu ka mu il ka ha ag ha ag ha ag no ag ha gul zug zug zug kaz kaz
kaz nuk aaz aaz aaz mog tar mog gul tar tar ogg kaz zug kil kil kil kaz lok kaz kaz kil ruk gul gul ogg ogg ruk tar ruk gul aaz kek lok nuk lok nuk kek
g g o l o a o o l n l n a o l n g n n l l l a n o g
`

let _t = tongue.replace(/\n|\r/g, ' ').split(' ')
let _e = ear.replace(/\n|\r/g, ' ').split(' ')

// console.log(_t.length, _e.length)

let dict = {}

_e.forEach((v, i) => {
  if (!dict[v]) dict[v] = []
  dict[v].push(tongue[i])
})

console.log(JSON.stringify(dict, null, 2))

console.log(Object.keys(dict).length, 'keys')
