angular.module('dashboard').controller 'DashboardEmployerNotificationsCtrl', [
  '$scope'
  'User'
  ($scope, User) ->
    User.clear_notifications($scope.current_user.id)
]