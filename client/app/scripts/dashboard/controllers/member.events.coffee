angular.module('dashboard').controller 'DashboardMemberEventsCtrl', [
  '$scope'
  '$rootScope'
  ($scope, $rootScope) ->

    console.log $scope.current_user

]