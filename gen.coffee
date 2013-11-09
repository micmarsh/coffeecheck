
#TODO:
#grunt and some tests
#a real algorithm for Arrays (fun!), a better namespace than "Gen", custom object constructor (the real deal)

_ = require 'lodash'

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
    constructor = Gen[name]
    unless Boolean constructor
        throw Error "No type '#{name}' defined in 'Gen' namespace"

    multiVarNew constructor, args

match = (typeObj) ->
    [name, args] = _.pairs(typeObj)[0]
    _match name, args

matchAll = (multiPropTypeObj) ->
    pairs = _.pairs multiPropTypeObj
    _.map pairs, (pair) ->
        _match.apply @, pair

class Gen.Array extends Gen.Interface

    _initLength: ({maxlength, minlength, length}) ->
        @lengthChooser = new Gen.Number
            max: maxlength or length
            min: minlength or length

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

exports.Gen = Gen
