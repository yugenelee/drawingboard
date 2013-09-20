angular.module('common').directive 'sidebar', [
  ->
    restrict: 'EA'
    replace: true
    scope: {}
    templateUrl: 'partials/common/sidebar.html'

    controller: [
      '$scope'
      '$rootScope'
      'Service'
      '$location'
      ($scope, $rootScope, Service, $location) ->
        $scope.services = Service.all
          order: 'created_at ASC'
        $scope.goTo = (service_name) ->
          $location.path "/services/#{service_name}"
    ]

]