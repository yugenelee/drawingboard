angular.module('account').directive 'forgotPasswordForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {}
    templateUrl: 'forms/account/forgot_password.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'Auth'
      ($scope, $rootScope, $routeParams, Auth) ->

        $scope.hasError = (input) ->
          !input.$valid && (input.$dirty || $scope.submitted)

        $scope.submitForm = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()
            Auth.forgot_password('Member', $scope.email, 'local')
          else
            $rootScope.notify_error 'Please enter a valid email'

        init = ->
          $scope.submitted = false
        init()
    ]
]