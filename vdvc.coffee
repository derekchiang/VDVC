jquery = require 'jquery'

class Manager
  buffer: {}
  store: {}

  clone: (obj) ->
    return jquery.extend(true, {}, obj)

  constructor: () ->
    this.next_id = 0

  objectId: (obj) ->
    if not obj?
      return null
    else
      if not obj.__id?
        obj.__id = this.next_id++
      return obj.__id

  add: (objects...) ->
    for obj in objects
      this.buffer[this.objectId(obj)] = this.clone(obj)

  commit: () ->
    console.log this.buffer
    for key, value of this.buffer
      console.log key
      if this.store[key]?
        this.store[key].push(value)
      else
        this.store[key] = [value]
      value.commitId = this.store[key].length - 1

  prev: (obj) ->
    objectArr = this.store[this.objectId(obj)]
    if objectArr
      if obj.commitId?
        if obj.commitId == 0
          throw "It's already the earliest version"
        else
          return objectArr[obj.commitId - 1]
      else
        # If no commitId, then it's the latest version
        console.log objectArr
        # Second to last element would be the previous version
        return objectArr[objectArr.length - 2]
    else
      throw "Object not versioned"

  next: (obj) ->
    objectArr = this.store[this.objectId(obj)]
    if objectArr
      if not obj.commitId? or obj.commitId == objectArr.length - 1
        throw "It's already the latest version"
      else
        return objectArr[obj.commitId + 1]
    else
      throw "Object not versioned"

manager = new Manager

derek =
  name: 'derek'
  age: 13
  move: () ->
    console.log 'haha'

manager.add derek
console.log derek
console.log manager.buffer
manager.commit()
console.log manager.store
derek.age = 16
derek.move = () ->
  console.log 'hehe'
derek.move()
manager.add derek
manager.commit()

derek.age = 20
manager.add(derek)
manager.commit()
prev_derek = manager.prev(derek)
console.log prev_derek.age
prev_derek.move()

now_derek = manager.next(prev_derek)
console.log now_derek.age
now_derek.move()

prev_derek = manager.prev(prev_derek)
console.log prev_derek.age
prev_derek.move()