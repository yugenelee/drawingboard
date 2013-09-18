angular.module('admin').controller 'AdminUsersCtrl', [
  '$scope'
  '$rootScope'
  'User'
  ($scope, $rootScope, User) ->

    $scope.users = User.all
      order: 'updated_at DESC'

]