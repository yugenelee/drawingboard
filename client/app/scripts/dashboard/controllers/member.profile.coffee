angular.module('dashboard').controller 'DashboardMemberProfileCtrl', [
  '$scope'
  '$rootScope'
  'FormHandler'
  ($scope, $rootScope, FormHandler) ->

    $scope.hasError = (input) ->
      !input.$valid && (input.$dirty || $scope.submitted)

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.form.$valid
        $scope.clear_notifications()
        $rootScope.current_user.put().then ((current_user)->
          $rootScope.current_user = current_user
          $scope.notify_success 'Your profile is updated successfully'
        ), ->
          window.scrollTo(0)
          $scope.notify_error 'Form has missing or invalid values'
      else
        FormHandler.validate $scope.form.$error

    init = ->
      $scope.submitted = false
    init()

]