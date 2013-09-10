angular.module('account').controller 'AccountEmailConfirmationCtrl', [
  '$scope'
  '$routeParams'
  'Auth'
  'User'
  ($scope, $routeParams, Auth, User) ->

    User.activate_with_token($routeParams.userId, $routeParams.token)
    .then (authenticated)->
      $scope.notify_success 'Your email has been verified'
      Auth.create_session {
        user_type: authenticated.user_type,
        auth_id: authenticated.auth_id,
        auth_provider: authenticated.auth_provider,
        token: authenticated.token
      }
    , ->
      $scope.notify_error 'We are unable to activate this account.'

    $scope.$on 'session:created', (ev, user) ->
      $scope.attemptLogin().then ( ->
        $scope.redirect_to "dashboard.#{user.user_type.toLowerCase()}.profile", success: 'Please proceed to furnish your account information'
      ), ->
        $scope.notify_error 'Unable to log you in'
]
