angular.module('account').directive 'registerMemberForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {}
    templateUrl: 'forms/account/register.member.html'
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
            additional_fields = {
              first_name: $scope.user.first_name,
              last_name: $scope.user.last_name,
              photo_url: 'styles/img/profile.jpg'
            }
            Auth.register('Member', $scope.user.email, 'local', $scope.user.email, $scope.user.password, additional_fields)

        init = ->
          $scope.submitted = false
        init()
    ]
]