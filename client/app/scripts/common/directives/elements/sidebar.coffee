angular.module('common').directive 'sidebar', [
  ->
    restrict: 'EA'
    replace: true
    templateUrl: 'partials/common/sidebar.html'

    controller: [
      '$scope'
      'Service'
      ($scope, Service) ->
        $scope.services = Service.all
          order: 'created_at ASC'
    ]

]