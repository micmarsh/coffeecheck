
_ = require 'lodash'

property = (generator, method) ->
    LIMIT = 100 #for now!

    _.reduce [0...LIMIT], (soFar, i) ->
        item = generator.next()
        soFar and method item
    , true

exports.property = property
