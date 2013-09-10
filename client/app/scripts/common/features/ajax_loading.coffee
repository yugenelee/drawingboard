angular.module('common').run [
  '$rootScope'
  ($rootScope) ->

    $rootScope.start_ajax = ->
      $rootScope.$broadcast 'ajax_loading:started'

    $rootScope.stop_ajax = ->
      $rootScope.$broadcast 'ajax_loading:stopped'

]
