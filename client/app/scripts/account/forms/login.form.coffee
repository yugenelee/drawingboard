angular.module('account').directive 'loginForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {}
    templateUrl: 'forms/account/login.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'Auth'
      ($scope, $rootScope, $routeParams, Auth) ->

        $scope.hasError = (input) ->
          !input.$valid && (input.$dirty || $scope.submitted)

        $scope.loginAsMember = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()
            Auth.authenticate('Member', $scope.user.email, 'local', $scope.user.password)

        $scope.loginAsVendor = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()
            Auth.authenticate('Vendor', $scope.user.email, 'local', $scope.user.password)

        init = ->
          $scope.submitted = false
        init()
    ]
]