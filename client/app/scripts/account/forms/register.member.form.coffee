angular.module('account').directive 'registerMemberForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {}
    templateUrl: 'forms/account/register.member.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'Auth'
      'FormHandler'
      ($scope, $rootScope, $routeParams, Auth, FormHandler) ->

        $scope.hasError = (input) ->
          !input.$valid && (input.$dirty || $scope.submitted)

        $scope.submitForm = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()
            additional_fields = {
              first_name: $scope.user.first_name,
              last_name: $scope.user.last_name,
            }
            Auth.register('Member', $scope.user.email, 'local', $scope.user.email, $scope.user.password, additional_fields)
          else
            FormHandler.validate $scope.form.$error
        init = ->
          $scope.submitted = false
        init()
    ]
]