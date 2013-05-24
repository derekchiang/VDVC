# VDVC

VDVC is a Very Dumb Version Control module, written in CoffeeScript.

VDVC is under development.  APIs may change at any time.

## Usage

VDVC tries to mimic git.
    
```coffeescript
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
```

## API

See `docs/`.

## Test

1. Install [Mocha](https://github.com/visionmedia/mocha): `npm install -g mocha`
2. Run `mocha` in the main directory.

Source code for tests can be found in `test/`.

## Limits

Because of the limits of JavaScript itself, some objects cannot be fully cloned, and therefore cannot be fully versioned.  The manager object returned by `new()`, for example, is not fully version-able, because it makes use of [private members and privileged methods](http://javascript.crockford.com/private.html).

Furthermore, VDVC appends an attribute "__id" to an object when it's called with `add()`, and appends "__commitId" when it's called with `commit()`.  What this means is that, if you compare a previous version of an object returned by VDVC with the actual previous object, they might not be deeply equal, because of the two additional attributes.  That said, this shouldn't matter in most scenarios.

## Roadmap

These are not plans, but rather just possibilities.

1. Add more methods
2. Make it possible to use a real DB as backend.