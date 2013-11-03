angular.module('platform').controller 'PaypalCancelledCtrl', [
  '$scope'
  'Payment'
  ($scope) ->
    $scope.redirect_to '/', error: 'Unable to complete payment.'
]