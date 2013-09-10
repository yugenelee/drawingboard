angular.module('common').run [
  '$rootScope'
  '$location'
  ($rootScope, $location) ->

    $rootScope.redirect_to = (path, options={}) ->
      path = path.replace(/^\//,'')
      $rootScope.notify_success options.success if options.success?
      $rootScope.notify_info options.info if options.info?
      $rootScope.notify_error options.error if options.error?
      $location.path "/#{path}"

]
