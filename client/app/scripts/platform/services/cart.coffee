angular.module('platform').factory 'Cart',[
  '$cookieStore'
  ($cookieStore) ->

    class Cart

      constructor: ->
        @_init()

      _init: ->
        @cart = $cookieStore.get 'CartSession'
        @requestKeys = $cookieStore.get 'RequestKeySession'
        if angular.isUndefined @cart
          @cart = {}
        if angular.isUndefined @requestKeys
          @requestKeys = {}
          @numberOfItems = 0
        else
          @numberOfItems = Object.keys(@requestKeys).length


      get: ->
        @cart

      getRequestKeys: ->
        @requestKeys

      add: (service_name, provider) ->
        if angular.isUndefined @cart[service_name]
          @cart[service_name] = {}
        @cart[service_name][provider.id] = provider.name
        @requestKeys[provider.id] = provider.name
        @numberOfItems += 1
        $cookieStore.put 'CartSession', @get()
        $cookieStore.put 'RequestKeySession', @getRequestKeys()

      remove: (service_name, provider_id) ->
        delete @cart[service_name][provider_id]
        delete @requestKeys[provider_id]
        if Object.keys(@cart[service_name]).length == 1
          delete @cart[service_name]
        @numberOfItems -= 1
        $cookieStore.put 'CartSession', @get()
        $cookieStore.put 'RequestKeySession', @getRequestKeys()

      destroy: ->
        @cart = {}
        @numberOfItems = 0
        $cookieStore.remove 'CartSession'
        $cookieStore.remove 'RequestKeySession'

      isProviderInCart: (provider_id)->
        @requestKeys[provider_id]?

      as_json: ->
        JSON.stringify @get()

      isEmpty: ->
        @as_json == '{}'

    return new Cart
]