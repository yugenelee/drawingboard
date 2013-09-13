angular.module('common').directive 'sidebar', [
  ->
    restrict: 'EA'
    replace: true
    templateUrl: 'partials/common/sidebar.html'

    controller: [
      '$scope'
      ($scope) ->
        $scope.categories =
          venues: 'Venues',
          catering: 'Catering',
          photography: 'Photography',
          videography: 'Videography'
    ]

]