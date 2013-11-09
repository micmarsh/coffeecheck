
#TODO:
#grunt and some tests
#a real algorithm for Arrays (fun!), a better namespace than "Gen", custom object constructor (the real deal)

Gen = { }

class Gen.Interface
    _gen: true
    next: ->
        throw Error "next method not implemented"

class Gen.Boolean extends Gen.Interface
    next: -> Boolean new Date() % 2

class Gen.Number extends Gen.Interface

    constructor: (args = {}) ->
        {@max, @min} = args
        @max ?= 10000
        @min ?= -10000

    next: ->
        range = @max - @min
        initial = Math.floor Math.random() * range
        initial + @min

class Gen.NonNegative extends Gen.Number
    constructor: (max = 10000) ->
        min = 1
        super {max, min}

class Gen.Array extends Gen.Interface
    constructor: (@type, options={}) ->
    #TODO initialize max and min lengths for now, maybe throw
    #an exception if type isn't number or boolean or instance of interface
    #this should be a seperate function that can check everything in
     the "Gen"
    #namespace. Yeah!!! like new Gen.Array 'Boolean' gets you a Gen.boolean, and new Gen.Array 'Array'
    #gets u type Gen.Array,
    next: ->

exports.Gen = Gen
