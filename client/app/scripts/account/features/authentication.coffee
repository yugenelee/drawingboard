angular.module('account').run [
  '$rootScope'
  'Auth'
  '$q'
  'SiteName'
  ($rootScope, Auth, $q, SiteName) ->

    $rootScope.logout = ->
      Auth.logout()
      $rootScope.$broadcast 'logged_out'
      $rootScope.redirect_to '', success: 'You are logged out'

    $rootScope.attemptLogin = (opts={})->
      deferred = $q.defer()
      if $rootScope.authenticated? and $rootScope.authenticated
        deferred.resolve($rootScope.current_user)
      else
        authenticated = Auth.user delegate: true
        authenticated.then ((user) ->
          $rootScope.current_user = user
          $rootScope.authenticated = true
          $rootScope.user_class = user.user_type
          $rootScope.user_type = user.user_type.toLowerCase()
          opts.successHandler?(user)
          deferred.resolve(user)
        ), ->
          $rootScope.current_user = null
          $rootScope.authenticated = false
          $rootScope.user_class = 'User'
          $rootScope.user_type = 'guest'
          opts.failedHandler?(user)
          deferred.reject('user is not logged in')
      deferred.promise

    angular.forEach ['logged_out', 'login:started'], (event) ->
      $rootScope.$on event, ->
        $rootScope.current_user = null
        $rootScope.authenticated = false
        $rootScope.user_class = 'User'
        $rootScope.user_type = 'guest'

    $rootScope.$on 'authenticate:success', (event, response) ->
      $rootScope.attemptLogin {
        successHandler: (user) ->
          success_msg = if response.register then "Welcome to #{SiteName}!" else 'You are logged in!'
          if $cookieStore.get('event_form')
            $rootScope.redirect_to "event.new", success: "Welcome to #{SiteName}, you can now submit your event!"
          else
            $rootScope.redirect_to "dashboard.#{user.user_type.toLowerCase()}.profile", success: success_msg
      }

    $rootScope.attemptLogin()

]