{Arb} = require './arbitrary'
{property} = require './property'
_ = require 'lodash'

do ->
    notes = new Arb.Object
        text: new Arb.String " "
        _id: {'String': '[A-Za-h0-9]{16}'}
        timestamp:
            'String': "(\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d\.\d+)|(\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d)|(\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d)"        # entities: new Arb.Object
        # entities: new Arb.Object

        # This needs functions with good scope so we can have nicely derived properties
        # maybe arugments to 'next' as well, that fields can also access via @ARGS or
        # whatever when they're functions. Damn, this will be interesting scoping, especially b/c
        # this^ typeObj is a separate thing from the generator object. Def not ready, need an
        # mvp. Later. These seem like an object specific-thing, but keep an open mind for uses
        # with more "primitive" types

doTimes = (times) ->
    (fn) ->
        (fn() for i in [0...times])

do100Times = doTimes 100

do10Times = doTimes 10

printResult = (fn) ->
    ->
        console.log fn()

print10Times = (generator) ->
    do10Times printResult _.bind generator.next, generator

DECORATION = '+++++++++++'
header = (title) ->
    console.log DECORATION + " #{title} " + DECORATION

trueOrFalse = new Arb.Boolean
mostlyTrue = new Arb.Boolean 0.9

number = new Arb.Number {max: 500, min: -500}
positives = new Arb.NonNegative 1000

collectionsOfBools = new Arb.Array trueOrFalse,
    maxlength: 5
    minlength: 2

noteTexts = new Arb.String '(#(todo|checkout|read|eat|quotes) ){1,3}[a-z 0-9]{10,30}'

notes = new Arb.Object
    text: noteTexts
    archived: {'Boolean': 0.1}
    timestamp: positives
    userIds: {'Array': [{'String': '[A-Za-h0-9]{16}'},
        maxlength: 3
        minlength: 1
    ]}

header 'Random Booleans'
print10Times trueOrFalse

header 'Random Booleans, 90% True'
print10Times mostlyTrue

header 'Some Random Numbers'
print10Times number

header 'Some Positive Numbers'
print10Times positives

header 'Arrays of Booleans'
print10Times collectionsOfBools

header 'Random Note Texts'
print10Times noteTexts

header 'Some Random Notes'
print10Times notes




