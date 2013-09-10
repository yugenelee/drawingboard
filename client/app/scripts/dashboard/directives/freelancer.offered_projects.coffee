angular.module('dashboard').directive 'freelancerOfferedProjects', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/dashboard/freelancer.offered_projects.html'
]