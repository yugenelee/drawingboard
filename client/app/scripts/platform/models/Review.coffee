angular.module('platform').factory 'Review', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel

    return new Model(Restangular, $rootScope, $filter, 'review', 'reviews')
]