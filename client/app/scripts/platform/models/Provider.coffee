angular.module('platform').factory 'Provider', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
    return new Model(Restangular, $rootScope, $filter, 'provider', 'providers')
]