vdvc = require './vdvc'

manager = vdvc.new()

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