
{Gen} = require './gen'
{property} = require './property'

posMaker = new Gen.NonNegative 83

arrayMaker = new Gen.Array {"Number": [{max: 200, min: 100}]}, {length: 3}

console.log 'woah ' + property posMaker, (number) ->
    result = number > 0
    console.log result
    return result

property arrayMaker, (array) ->
    console.log JSON.stringify array


