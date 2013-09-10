angular.module('platform').factory 'JobCategory', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
    return new Model(Restangular, $rootScope, $filter, 'job_category', 'job_categories')
]