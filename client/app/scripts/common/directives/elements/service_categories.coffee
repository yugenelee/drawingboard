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
          if $rootScope.authenticated
            $location.path "/services/#{service_name}"
          else
            $rootScope.notify_info 'You need to login in order to view the listing.'
    ]
]