angular.module('common').directive 'serviceCategories', [
  ->
    restrict: 'EA'
    replace: true
    scope: {}
    templateUrl: 'partials/common/service_categories.html'
    controller: [
      '$scope'
      '$rootScope'
      '$location'
      ($scope, $rootScope, $location) ->
        $scope.goTo = (service_name) ->
          $location.path "/services/#{service_name}"
    ]
]