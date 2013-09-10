angular.module('account').controller 'AccountResetPasswordCtrl', [
  '$scope'
  '$routeParams'
  'User'
  ($scope, $routeParams, User) ->

    $scope.user = {new_password: ''}

    $scope.submitForm = ->
      User.reset_password_with_token($routeParams.userId, $routeParams.token, $scope.user.new_password)
      .then ( ->
        $scope.redirect_to 'home', success: 'Your password is changed successfully. Please login'
      ), ->
        $scope.notify_error 'Unable to reset password. Token is invalid.'
]
