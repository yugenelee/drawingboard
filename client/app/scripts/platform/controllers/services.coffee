angular.module('platform').controller 'ServicesCtrl', [
  '$scope'
  'service'
  ($scope, service) ->
    $scope.service = service
]