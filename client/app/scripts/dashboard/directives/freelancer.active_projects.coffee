angular.module('dashboard').directive 'freelancerActiveProjects', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/dashboard/freelancer.active_projects.html'
]