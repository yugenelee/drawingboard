angular.module('platform').factory 'Provider', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
      approve: (id) ->
        Restangular.one('providers', id).customPUT 'approve', {}, {}
    return new Model(Restangular, $rootScope, $filter, 'provider', 'providers')
]