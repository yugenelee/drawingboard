angular.module('account').factory 'Session',[
  '$cookieStore'
  ($cookieStore) ->

    class Session

      constructor: ->
        @_init()

      _init: ->
        loaded = $cookieStore.get 'AuthSession'
        #loaded = JSON.parse localStorage.getItem 'AuthSession'
        @user_type = loaded?.user_type
        @auth_id = loaded?.auth_id
        @auth_provider = loaded?.auth_provider
        @token = loaded?.token

      attributes: ->
        {
          user_type: @user_type,
          auth_id: @auth_id,
          auth_provider: @auth_provider,
          token: @token
        }

      set: (user_type, auth_id, auth_provider, token) ->
        @user_type = user_type
        @auth_id = auth_id
        @auth_provider = auth_provider
        @token = token
        $cookieStore.put 'AuthSession', @attributes()
        #localStorage.setItem 'AuthSession', @as_json()

      destroy: ->
        @user_type = null
        @auth_id = null
        @auth_provider = null
        @token = null
        $cookieStore.remove 'AuthSession'
        #localStorage.removeItem 'AuthSession'

      as_json: ->
        JSON.stringify @attributes()

      isEmpty: ->
        @as_json == '{}'

    return new Session
]