angular.module('account').factory 'Vendor', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel

      register: (user_type, auth_id, auth_provider, email, password, additional_fields) ->
        fields = {user_type, auth_id, auth_provider, email, password, additional_fields}
        @before_operation fields
        Restangular.all('vendors').customPOST 'register', {}, {}, fields


    return new Model(Restangular, $rootScope, $filter, 'vendor', 'vendors')
]