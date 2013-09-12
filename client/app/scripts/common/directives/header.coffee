angular.module('common').directive 'header', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/common/header.html'

    controller: [
      '$scope'
      '$dialog'
      ($scope, $dialog) ->

        $scope.openLoginDialog = ->
          $dialog.dialog({
            controller: dialogCtrls.login
          }).open('dialogs/account.login.html')

        $scope.openRegisterDialog = ->
          $dialog.dialog({
            controller: dialogCtrls.register
          }).open('dialogs/account.register.html')

        $scope.openForgotPasswordDialog = ->
          $dialog.dialog({
            controller: dialogCtrls.forgotPassword
          }).open('dialogs/account.forgot_password.html')
    ]

]