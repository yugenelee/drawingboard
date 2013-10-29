angular.module('platform').factory 'Priceplan', [
  'Restangular'
  '$rootScope'
  '$filter'
  'SiteUrl'
  (Restangular, $rootScope, $filter, SiteUrl) ->
    class Model extends BaseModel

    return new Model(Restangular, $rootScope, $filter, 'priceplan', 'priceplans')
]