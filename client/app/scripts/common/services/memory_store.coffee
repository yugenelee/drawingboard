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