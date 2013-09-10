angular.module('dashboard').directive 'employerPendingProjects', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/dashboard/employer.pending_projects.html'
    controller: [
      '$scope'
      ($scope) ->
        $scope.fulfillBid = (bidder, project) ->
          console.log project
    ]
]