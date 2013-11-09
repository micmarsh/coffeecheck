
{Gen} = require './gen'
{property} = require './property'

posMaker = new Gen.NonNegative 83

console.log 'woah ' + property posMaker, (number) ->
    result = number > 0
    console.log result
    return result



