angular.module('dashboard').controller 'DashboardFreelancerNotificationsCtrl', [
  '$scope'
  'User'
  ($scope, User) ->
    User.clear_notifications($scope.current_user.id)
]