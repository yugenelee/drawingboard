angular.module('admin').controller 'AdminEventsCtrl', [
  '$scope'
  '$rootScope'
  'Event'
  ($scope, $rootScope, Event) ->

    $scope.events = Event.all
      order: 'updated_at DESC'

]