
{Arb} = require './arbitrary'
{property} = require './property'

posMaker = new Arb.NonNegative 83

arrayMaker = new Arb.Array {"Number": [{max: 200, min: -100}]}, {maxlength: 8}
bArrayMaker = new Arb.Array {"Boolean":[]}, {length:4}

posCoords = new Arb.Array {"Tuple": [posMaker]}, {length: 3}

notes = new Arb.Object
    timestamp: posMaker
    userIds: arrayMaker
    stashed: {"Boolean": []}

property notes, (array) ->
    console.log array
    return true



