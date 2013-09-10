angular.module('account').controller 'EmployerRegisterCtrl', [
  '$scope'
  'Auth'
  'CustomProvider'
  ($scope, Auth, CustomProvider) ->

    $scope.linkedinConnect = ->
      CustomProvider.connect('linkedin', 'Employer', 'employer')

    $scope.submitForm = ->
      $scope.clear_notifications()
      additional_fields = {
        first_name: $scope.user.first_name,
        last_name: $scope.user.last_name,
        photo_url: 'styles/img/profile.jpg'
      }
      Auth.register('Employer', $scope.user.email, 'local', $scope.user.email, $scope.user.password, additional_fields)
]