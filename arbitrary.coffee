
#TODO:
#grunt and some tests
#string gen from regexes! (shi)
#imperfect objects

_ = require 'lodash'

Arb = { }

class Arb.Interface
    _gen: true
    next: ->
        throw Error "next method not implemented"
    toArray: (size = 100) ->
        _.map [0...size], => @next()

isArb = (object) ->
    {_gen, next, toArray} = object
    Boolean _gen and next and toArray

class Arb.Boolean extends Arb.Interface
    constructor: (@PROB = 0.5) ->
    next: -> Math.random() < @PROB

class Arb.Number extends Arb.Interface

    constructor: (args = {}) ->
        {@max, @min} = args
        @max ?= 10000
        @min ?= -10000

    next: ->
        range = @max - @min
        initial = Math.floor Math.random() * range
        initial + @min

class Arb.NonNegative extends Arb.Number
    constructor: (max = 10000) ->
        min = 1
        super {max, min}

multiVarNew = (constructor, args) ->
    {length} = args
    [arg0, arg1, arg2] = args
    if length > 3
        throw new Error "More than 3 arguments? Really?"

    if length is 0
        new constructor
    else if length is 1
        new constructor arg0
    else if length is 2
        new constructor arg0, arg1
    else if length is 3
        new constructor arg0, arg1, arg2

_match = (name, args) ->
    constructor = Arb[name]
    unless Boolean constructor
        throw Error "No type '#{name}' defined in 'Arb' namespace"

    multiVarNew constructor, args

match = (typeObj) ->
    if isArb typeObj
        typeObj
    else if _.isObject typeObj
        [name, args] = _.pairs(typeObj)[0]
        _match name, args
    else
        throw new Error "WTF type is that?"

matchAll = (multiPropTypeObj) ->
    pairs = _.pairs multiPropTypeObj
    _.map pairs, (pair) ->
        _match.apply @, pair

class Arb.Array extends Arb.Interface

    _initLength: ({maxlength, minlength, length}) ->
        @lengthChooser = new Arb.Number
            max: maxlength or length or 100
            min: minlength or length or 0

    constructor: (type, options={}) ->
        unless type?
            throw Error "Need to define a type for Arrays"
        @_initLength options
        @itemMaker = match type
    # a @type of of form {'Number':[{max: 3, min: 2}]}
    next: ->
        length = @lengthChooser.next()
        _.map [0...length], =>
            @itemMaker.next()

class Arb.Tuple extends Arb.Array
    constructor: (type, length = 2)->
        super type, {length}

toObject = (pairs) ->
    result = {}
    for [key, value] in pairs
        result[key] = value
    return result

class Arb.Object extends Arb.Interface
    constructor: (typeMap) ->
        convertedTypes = _.map typeMap, (type, key) ->
            [key, match type]
        @typeMap = toObject convertedTypes

    next: ->
        toObject _.map @typeMap, (type, key) ->
            [key, type.next()]

exports.Arb = Arb
