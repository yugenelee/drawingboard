angular.module('common').config [
  '$httpProvider'
  ($httpProvider) ->

    interceptor = ["$q", "$injector", "$rootScope", ($q, $injector, $rootScope) ->
      success = (response) ->
        $http = $injector.get("$http")
        $rootScope.$broadcast('ajax_loading:stopped')  if $http.pendingRequests.length < 1
        response
      error = (response) ->
        $http = $injector.get("$http")
        $rootScope.$broadcast('ajax_loading:stopped')  if $http.pendingRequests.length < 1
        $q.reject response
      (promise) ->
        $rootScope.$broadcast('ajax_loading:started')
        promise.then success, error
    ]

    $httpProvider.responseInterceptors.push interceptor
]

