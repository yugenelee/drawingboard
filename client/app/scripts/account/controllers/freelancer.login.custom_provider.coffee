angular.module('account').controller 'FreelancerLoginCustomProviderCtrl', [
  '$scope'
  'Auth'
  'MemoryStore'
  ($scope, Auth, MemoryStore) ->

    info = MemoryStore.get('auth_info')
    $scope.user = info
    MemoryStore.clear()

    $scope.submitForm = ->
      $scope.clear_notifications()
      Auth.authenticate('Freelancer', $scope.user.auth_id, $scope.user.auth_provider, $scope.user.password)

    $scope.forgotPassword = ->
      Auth.forgot_password(info.user_class, info.auth_id, info.auth_provider)
]