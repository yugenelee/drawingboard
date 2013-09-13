angular.module('platform').factory 'Service', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
      get_from_name: (name) ->
        Restangular.all('services').customGET 'get_from_name', {name}
    return new Model(Restangular, $rootScope, $filter, 'service', 'services')
]