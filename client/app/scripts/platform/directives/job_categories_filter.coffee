angular.module('platform').directive 'jobCategoriesFilter', [
  ->
    restrict: 'E'
    templateUrl: 'partials/platform/job_categories_filter.html'
    scope: {}
    controller: [
      '$scope'
      ($scope) ->
        $scope.setJobTitle = ($event) ->
          console.log($event.target.innerHTML)
          $scope.$emit 'search:menu', name: 'job_title', selected: $event.target.innerHTML
    ]
]