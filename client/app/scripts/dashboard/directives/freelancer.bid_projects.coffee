angular.module('dashboard').directive 'freelancerBidProjects', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/dashboard/freelancer.bid_projects.html'
]