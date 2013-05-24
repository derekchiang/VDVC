vdvc = require '../vdvc'
assert = require 'assert'

describe 'VDVC', () ->
  manager = null
  obj = null

  beforeEach () ->
    manager = vdvc.new()
    obj =
      name: 'derek'
      age: '20'
      speak: () ->
        console.log 'Hello Everybody!'

  describe '#clone()', () ->
    it 'should return a deeply-equal object', () ->
      assert.deepEqual obj, manager.clone(obj)

    it 'should work for array', () ->
      arr = [1, 'haha', obj]
      assert.deepEqual arr, manager.clone(arr)

  describe '#add() and #commit()', () ->
    it 'should not throw errors', () ->
      assert.doesNotThrow () ->
        manager.add obj
        manager.commit()

    it 'should work with multiple objects', () ->
      assert.doesNotThrow () ->
        anotherObj =
          name: 'bob'
          age: 40
          speak: () ->
            console.log 'zzz...'

        manager.add obj, anotherObj
        manager.commit()

  describe '#prev()', () ->
    it 'should return the previous version of the object', () ->
      oldObj = manager.clone obj

      manager.add obj
      manager.commit()

      obj.age = 30
      manager.add obj
      manager.commit()

      prevObj = manager.prev obj
      manager.makeClean prevObj

      assert.deepEqual oldObj, prevObj