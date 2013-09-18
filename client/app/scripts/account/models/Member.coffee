angular.module('account').factory 'Member', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Member extends BaseModel
    return new Member(Restangular, $rootScope, $filter, 'member', 'members')
]