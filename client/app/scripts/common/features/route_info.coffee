angular.module('common').run [
  '$rootScope'
  '$location'
  ($rootScope, $location) ->

    $rootScope.$current_route = '/'

    $rootScope.$on '$routeChangeSuccess', ->
      $rootScope.$current_route = $location.path()

]
