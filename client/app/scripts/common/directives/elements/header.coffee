angular.module('common').directive 'header', [
  ->
    restrict: 'EA'
    replace: true
    templateUrl: 'partials/common/header.html'

]