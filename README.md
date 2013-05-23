# VDVC

VDVC is a Very Dumb Version Control module.

## Usage

VDVC tries to mimic git.
    
    ```coffee
    # Import module
    vdvc = require 'vdvc'

    # Initialize a manager
    manager = vdvc.new()
    ```

Think of a manager as a repository.

    ```coffee
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
    
    ```coffee
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

    ```coffee
    # Go back to previous commit
    prev_derek = manager.prev(derek)
    console.log prev_derek.age # 20

    prev_tom = manager.prev(tom)
    prev_tom.speak # 'Not bad.'
    ```