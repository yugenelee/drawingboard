angular.module('dashboard').directive 'employerActiveProjects', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/dashboard/employer.active_projects.html'
]