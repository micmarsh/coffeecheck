
{Gen} = require './gen'
{property} = require './property'

posMaker = new Gen.NonNegative 83

arrayMaker = new Gen.Array {"Number": [{max: 200, min: -100}]}, {maxlength: 8}
bArrayMaker = new Gen.Array {"Boolean":[]}, {length:4}

posCoords = new Gen.Array {"Tuple": [{'NonNegative': [100]}]}, {length: 3}

property posCoords, (array) ->
    console.log array
    return true



