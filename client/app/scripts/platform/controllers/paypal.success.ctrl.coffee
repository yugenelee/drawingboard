angular.module('platform').controller 'PaypalSuccessCtrl', [
  '$scope'
  'Payment'
  ($scope, Payment) ->
    $scope.message = ''
]