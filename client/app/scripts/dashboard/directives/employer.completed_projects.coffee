angular.module('dashboard').directive 'employerCompletedProjects', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/dashboard/employer.completed_projects.html'
]