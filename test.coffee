
{Gen} = require './gen'
{property} = require './property'

posMaker = new Gen.NonNegative 83

arrayMaker = new Gen.Array {"Number": [{max: 200, min: -100}]}, {maxlength: 8}
bArrayMaker = new Gen.Array {"Boolean":[]}, {length:4}

posCoords = new Gen.Array {"Tuple": [posMaker]}, {length: 3}

notes = new Gen.Object
    timestamp: posMaker
    userIds: arrayMaker
    stashed: {"Boolean": []}

property notes, (array) ->
    console.log array
    return true



