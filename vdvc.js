// Generated by CoffeeScript 1.6.2
(function() {
  var Manager, derek, jquery, manager, now_derek, prev_derek,
    __slice = [].slice;

  jquery = require('jquery');

  Manager = (function() {
    Manager.prototype.buffer = {};

    Manager.prototype.store = {};

    Manager.prototype.clone = function(obj) {
      return jquery.extend(true, {}, obj);
    };

    function Manager() {
      this.next_id = 0;
    }

    Manager.prototype.objectId = function(obj) {
      if (obj == null) {
        return null;
      } else {
        if (obj.__id == null) {
          obj.__id = this.next_id++;
        }
        return obj.__id;
      }
    };

    Manager.prototype.add = function() {
      var obj, objects, _i, _len, _results;

      objects = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      _results = [];
      for (_i = 0, _len = objects.length; _i < _len; _i++) {
        obj = objects[_i];
        _results.push(this.buffer[this.objectId(obj)] = this.clone(obj));
      }
      return _results;
    };

    Manager.prototype.commit = function() {
      var key, value, _ref, _results;

      console.log(this.buffer);
      _ref = this.buffer;
      _results = [];
      for (key in _ref) {
        value = _ref[key];
        console.log(key);
        if (this.store[key] != null) {
          this.store[key].push(value);
        } else {
          this.store[key] = [value];
        }
        _results.push(value.commitId = this.store[key].length - 1);
      }
      return _results;
    };

    Manager.prototype.prev = function(obj) {
      var objectArr;

      objectArr = this.store[this.objectId(obj)];
      if (objectArr) {
        if (obj.commitId != null) {
          if (obj.commitId === 0) {
            throw "It's already the earliest version";
          } else {
            return objectArr[obj.commitId - 1];
          }
        } else {
          console.log(objectArr);
          return objectArr[objectArr.length - 2];
        }
      } else {
        throw "Object not versioned";
      }
    };

    Manager.prototype.next = function(obj) {
      var objectArr;

      objectArr = this.store[this.objectId(obj)];
      if (objectArr) {
        if ((obj.commitId == null) || obj.commitId === objectArr.length - 1) {
          throw "It's already the latest version";
        } else {
          return objectArr[obj.commitId + 1];
        }
      } else {
        throw "Object not versioned";
      }
    };

    return Manager;

  })();

  manager = new Manager;

  derek = {
    name: 'derek',
    age: 13,
    move: function() {
      return console.log('haha');
    }
  };

  manager.add(derek);

  console.log(derek);

  console.log(manager.buffer);

  manager.commit();

  console.log(manager.store);

  derek.age = 16;

  derek.move = function() {
    return console.log('hehe');
  };

  derek.move();

  manager.add(derek);

  manager.commit();

  derek.age = 20;

  manager.add(derek);

  manager.commit();

  prev_derek = manager.prev(derek);

  console.log(prev_derek.age);

  prev_derek.move();

  now_derek = manager.next(prev_derek);

  console.log(now_derek.age);

  now_derek.move();

  prev_derek = manager.prev(prev_derek);

  console.log(prev_derek.age);

  prev_derek.move();

}).call(this);
