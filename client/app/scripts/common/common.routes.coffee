angular.module('account').config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->

    $routeProvider.otherwise redirectTo: '/home'
    $locationProvider.html5Mode(false)
]
