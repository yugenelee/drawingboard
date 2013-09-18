angular.module('admin').directive 'adminDashboardSidebar', [
  ->
    restrict: 'EA'
    replace: true
    templateUrl: 'partials/admin/admin_dashboard_sidebar.html'

]