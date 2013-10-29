angular.module('platform').controller 'PaypalCancelledCtrl', [
  '$scope'
  'Payment'
  ($scope, Payment) ->
    $scope.message = ''
]