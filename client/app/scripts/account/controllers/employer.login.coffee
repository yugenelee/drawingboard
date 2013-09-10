angular.module('account').controller 'EmployerLoginCtrl', [
  '$scope'
  'Auth'
  'CustomProvider'
  '$dialog'
  ($scope, Auth, CustomProvider, $dialog) ->

    $scope.linkedinConnect = ->
      CustomProvider.connect('linkedin', 'Employer', 'employer')

    $scope.submitForm = ->
      $scope.clear_notifications()
      Auth.authenticate('Employer', $scope.user.email, 'local', $scope.user.password)

    $scope.forgotPassword = ->
      $dialog.dialog().open('dialogs/account.forgot_password.html').then (result) ->
        if result?
          Auth.forgot_password('Employer', result, 'local')


]