angular.module('platform').factory 'Cart',[
  '$cookieStore'
  ($cookieStore) ->

    class Cart

      constructor: ->
        @_init()

      _init: ->
        @cart = $cookieStore.get 'CartSession'
        if angular.isUndefined @cart
          @cart = {}

      get: ->
        @cart

      add: (service_name, provider) ->
        if angular.isUndefined @cart[service_name]
          @cart[service_name] = {}
        @cart[service_name][provider.id] = provider.name
        $cookieStore.put 'CartSession', @get()

      remove: (service_name, provider_id) ->
        delete @cart[service_name][provider_id]
        if Object.keys(@cart[service_name]).length == 1
          delete @cart[service_name]
        $cookieStore.put 'CartSession', @get()

      destroy: ->
        @cart = {}
        $cookieStore.remove 'CartSession'

      as_json: ->
        JSON.stringify @get()

      isEmpty: ->
        @as_json == '{}'

    return new Cart
]