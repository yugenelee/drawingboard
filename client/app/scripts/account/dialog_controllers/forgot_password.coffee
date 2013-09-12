dialogCtrls.forgotPassword = [
  '$scope'
  'dialog'
  ($scope, dialog) ->
    $scope.close = (result)->
      dialog.close result
]