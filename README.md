# VDVC

VDVC is a Very Dumb Version Control module, written in CoffeeScript.

VDVC is under development.  APIs may change at any time.

## Usage

VDVC tries to mimic git.
    
```coffeescript
# Import module
vdvc = require 'vdvc'

# Initialize a manager
manager = vdvc.new()
```

Think of a manager as a repository.

```coffeescript
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
manager.add derek tom

# Commit
manager.commit()
```

Now the two objects are versioned.  Let's make some changes to them:
    
```coffeescript
# Time goes on
derek.age = '40'

# Tom becomes rude
tom.speak = () ->
  console.log 'Bullshit'

# Add
manager.add derek tom

# Commit
manager.commit()
```

Now, let's go back to previous versions:

```coffeescript
# Go back to previous commit
prev_derek = manager.prev(derek)
console.log prev_derek.age # 20

prev_tom = manager.prev(tom)
prev_tom.speak # 'Not bad.'
```

## Limits

Because of the limits of JavaScript itself, some objects cannot be fully cloned, and therefore cannot be fully versioned.  The manager object returned by `new()`, for example, is not fully version-able, because it makes use of [private members and privileged methods](http://javascript.crockford.com/private.html).