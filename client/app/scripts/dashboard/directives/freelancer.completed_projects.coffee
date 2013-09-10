angular.module('dashboard').directive 'freelancerCompletedProjects', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/dashboard/freelancer.completed_projects.html'
]