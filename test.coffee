vdvc = require './vdvc'

# Global Variables
manager = null
obj = null

exports.groupOne =
  setUp: (cb) ->
    manager = vdvc.new()
    obj =
      name: 'derek'
      age: '20'
      speak: () ->
        console.log "What's up"
    cb()

  testClone: (test) ->  
    clonedObj = manager.clone obj
    test.deepEqual clonedObj, obj, "Clone failed"
    test.done()

  testAddAndCommit: (test) ->
    test.doesNotThrow () ->
      manager.add obj
      manager.commit()
    , 'Should not throw errors'

    test.done()

  testPrev: (test) ->
    manager.add obj
    manager.commit()

    oldName = obj.name

    obj.name = 'nemo'
    manager.add obj
    manager.commit()

    prev_obj = manager.prev obj
    test.strictEqual prev_obj.name, oldName
    test.done()
