angular.module('account').factory 'Freelancer', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
    return new Model(Restangular, $rootScope, $filter, 'freelancer', 'freelancers')
]