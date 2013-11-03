angular.module('platform').factory 'Priceplan', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel

    return new Model(Restangular, $rootScope, $filter, 'priceplan', 'priceplans')
]