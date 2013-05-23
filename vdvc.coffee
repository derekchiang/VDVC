jquery = require 'jquery'

class Manager
  constructor: () ->
    # Private fields

    next_id = 0

    # Temporary buffer for holding
    # added but not commited objects
    buffer = {}

    # Storing all tracked objects
    store = {}

    # Private methods
    getObjectArr = (obj) ->
      return store[objectId(obj)]


    objectId = (obj) ->
      if not obj?
        return null
      else
        if not obj.__id?
          obj.__id = next_id++
        return obj.__id

    # Privileged methods
    this.clone = (obj) ->
      return jquery.extend(true, {}, obj)      

    # Add objects to be ready for commit
    this.add = (objects...) ->
      for obj in objects
        buffer[objectId(obj)] = this.clone(obj)

    # Commit all changes
    this.commit = () ->
      for key, value of buffer
        if store[key]?
          store[key].push(value)
        else
          store[key] = [value]
        value.commitId = store[key].length - 1
      buffer = {}

    # Return the previous commit
    this.prev = (obj) ->
      objectArr = getObjectArr obj
      if objectArr
        if obj.commitId?
          if obj.commitId == 0
            throw "It's already the earliest version"
          else
            return objectArr[obj.commitId - 1]
        else
          # If no commitId, then it's the latest version
          # Second to last element would be the previous version
          return objectArr[objectArr.length - 2]
      else
        throw "Object not versioned"

    # Return the next commit
    this.next = (obj) ->
      objectArr = getObjectArr obj
      if objectArr
        if not obj.commitId? or obj.commitId == objectArr.length - 1
          throw "It's already the latest version"
        else
          return objectArr[obj.commitId + 1]
      else
        throw "Object not versioned"

    # Return to a particular commit
    this.reset = (obj, commitId) ->
      objectArr = getObjectArr obj
      if 0 <= commitId < objectArr.length
        return objectArr[commitId]
      else
        throw "Invalid commit id"

module.exports.new = () ->
  return (new Manager)