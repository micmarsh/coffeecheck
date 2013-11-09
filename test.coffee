
{Gen} = require './gen'
{property} = require './property'

posMaker = new Gen.NonNegative 83

arrayMaker = new Gen.Array {"Number": [{max: 200, min: 100}]}, {length: 3}

property arrayMaker, (array) ->
    console.log array
    return true


