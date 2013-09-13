
###
  Memory store serves to persist data across ng-view switches, it does not persist data in cookie or localStorage
  Usage for this can be reset password, passing data from one controller to another.
###
angular.module('common').service 'MemoryStore', [
  ->
    data = {}
    @set = (key, value) ->
      data[key] = value
    @get = (key) ->
      data[key]
    @del = (key) ->
      delete data[key]
    @inspect = ->
      data
    @clear = ->
      data = {}
    @ #return self
]