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

# Version a manager itself

sec_manager = vdvc.new()

sec_manager.add(manager)
sec_manager.commit()

derek.age = 20
manager.add(derek)
manager.commit()
prev_derek = manager.prev(derek)
console.log prev_derek.age
prev_derek.move()

sec_manager.add(manager)
sec_manager.commit()

now_derek = manager.next(prev_derek)
console.log now_derek.age
now_derek.move()

prev_derek = manager.prev(prev_derek)
console.log prev_derek.age
prev_derek.move()

prev_manager = sec_manager.prev(manager)

now_derek = prev_manager.next(prev_derek)
console.log now_derek.age
now_derek.move()

old_derek = manager.reset(now_derek, 0)
old_derek.move()
console.log old_derek.age


# Tests from README

# Import module
# Assuming `vdvc.js` is in the current directory
vdvc = require './vdvc'

# Initialize a manager
manager = vdvc.new()

# Think of a manager as a repository.

# Create a sample object
derek =
  name: 'Derek'
  age: '20'
  speak: () ->
    console.log 'Yo how is it going?'

tom =
  name: 'Tom'
  age: '24'
  speak: () ->
    console.log 'Not bad.'

# Add
manager.add derek, tom

# Commit
manager.commit()

# Now the two objects are versioned.  Let's make some changes to them:

# Time goes on
derek.age = '40'

# Tom becomes rude
tom.speak = () ->
  console.log 'Bullshit'

# Add
manager.add derek, tom

# Commit
manager.commit()

# Now, let's go back to previous versions:

# Go back to previous commit
prev_derek = manager.prev derek
console.log prev_derek.age # 20

prev_tom = manager.prev tom
prev_tom.speak() # 'Not bad.'