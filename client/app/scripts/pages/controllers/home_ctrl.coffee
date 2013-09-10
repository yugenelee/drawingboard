angular.module('pages').controller 'HomeCtrl', [
  '$scope'
  'freelancers'
  ($scope, freelancers) ->
    $scope.freelancers_start = freelancers.slice(0,4)
    $scope.freelancers_end = freelancers.slice(4)
]