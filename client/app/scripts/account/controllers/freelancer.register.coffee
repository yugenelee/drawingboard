angular.module('account').controller 'FreelancerRegisterCtrl', [
  '$scope'
  'Auth'
  'CustomProvider'
  ($scope, Auth, CustomProvider) ->

    $scope.linkedinConnect = ->
      CustomProvider.connect('linkedin', 'Freelancer', 'freelancer')

    $scope.submitForm = ->
      $scope.clear_notifications()
      additional_fields = {
        first_name: $scope.user.first_name,
        last_name: $scope.user.last_name,
        photo_url: 'styles/img/profile.jpg'
      }
      Auth.register('Freelancer', $scope.user.email, 'local', $scope.user.email, $scope.user.password, additional_fields)
]