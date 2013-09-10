angular.module('account').controller 'FreelancerRegisterCustomProviderCtrl', [
  '$scope'
  'Auth'
  'MemoryStore'
  ($scope, Auth, MemoryStore) ->

    info = MemoryStore.get('auth_info')
    console.log info
    $scope.user = info
    MemoryStore.clear()

    $scope.submitForm = ->
      $scope.clear_notifications()
      Auth.register('Freelancer', $scope.user.auth_id, $scope.user.auth_provider, $scope.user.email, $scope.user.password, $scope.user.additional_fields)
]