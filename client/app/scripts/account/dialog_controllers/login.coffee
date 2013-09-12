dialogCtrls.login = [
  '$scope'
  'dialog'
  '$dialog'
  '$timeout'
  ($scope, dialog, $dialog, $timeout) ->
    $scope.close = (result)->
      dialog.close result

    $scope.openRegisterDialog = ->
      dialog.close()
      $timeout ->
        $dialog.dialog({
          controller: dialogCtrls.register
        }).open('dialogs/account.register.html')
      , 500

    $scope.openForgotPasswordDialog = ->
      dialog.close()
      $timeout ->
        $dialog.dialog({
          controller: dialogCtrls.forgotPassword
        }).open('dialogs/account.forgot_password.html')
      , 500
]