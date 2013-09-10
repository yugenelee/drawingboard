angular.module('account').factory 'User', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class User extends BaseModel
      get_from_account: (user_type, auth_id, auth_provider) ->
        @before_operation {user_type, auth_id, auth_provider}
        Restangular.all('users').customGET 'get_from_account', {user_type, auth_id, auth_provider}

      authenticate_with_token: (session) ->
        @before_operation {session}
        Restangular.all('users').customGET 'authenticate_with_token', session

      register: (user_type, auth_id, auth_provider, email, password, additional_fields) ->
        fields = {user_type, auth_id, auth_provider, email, password, additional_fields}
        @before_operation fields
        Restangular.all('users').customPOST 'register', {}, {}, fields

      authenticate: (user_type, auth_id, auth_provider, password) ->
        fields = {user_type, auth_id, auth_provider, password}
        @before_operation fields
        Restangular.all('users').customGET 'authenticate', fields

      activate_with_token: (user_id, token) ->
        fields = {token}
        @before_operation fields
        Restangular.one('users', user_id).customGET 'activate_with_token', fields

      forgot_password: (user_type, auth_id, auth_provider) ->
        fields = {user_type, auth_id, auth_provider}
        @before_operation fields
        Restangular.all('users').customPOST 'forgot_password', {}, {}, fields

      reset_password_with_token: (user_id, token, new_password) ->
        fields = {token, new_password}
        console.log fields
        @before_operation fields
        Restangular.one('users', user_id).customPOST 'reset_password_with_token', {}, {}, fields

      clear_notifications: (user_id) ->
        Restangular.one('users', user_id).customPOST 'clear_notifications', {}, {}

    return new User(Restangular, $rootScope, $filter, 'user', 'users')
]