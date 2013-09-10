angular.module('account').factory 'Employer', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
    return new Model(Restangular, $rootScope, $filter, 'employer', 'employers')
]