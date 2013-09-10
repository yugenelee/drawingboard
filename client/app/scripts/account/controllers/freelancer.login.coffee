angular.module('account').controller 'FreelancerLoginCtrl', [
  '$scope'
  'Auth'
  'CustomProvider'
  '$dialog'
  ($scope, Auth, CustomProvider, $dialog) ->

    $scope.linkedinConnect = ->
      CustomProvider.connect('linkedin', 'Freelancer', 'freelancer')

    $scope.submitForm = ->
      $scope.clear_notifications()
      Auth.authenticate('Freelancer', $scope.user.email, 'local', $scope.user.password)

    $scope.forgotPassword = ->
      $dialog.dialog().open('dialogs/account.forgot_password.html').then (result) ->
        if result?
          Auth.forgot_password('Freelancer', result, 'local')


]