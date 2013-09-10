angular.module('common').run [
  '$rootScope'
  '$log'
  ($rootScope, $log) ->

    $rootScope.alert = (msg) ->
      alert(msg)

    $rootScope.log = (msg) ->
      $log.log(msg)

    $rootScope.warn = (msg) ->
      $log.warn(msg)

    $rootScope.error = (msg) ->
      $log.error(msg)
]
