

property = (generator, method) ->
    LIMIT = 100 #for now!

    [0...LIMIT].reduce (soFar, i) ->
        item = generator.next()
        soFar and method item
    , true

exports.property = property
