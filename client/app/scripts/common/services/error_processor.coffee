angular.module('common').service 'ErrorProcessor', [
  '$rootScope'
  '$log'
  ($rootScope, $log) ->
    @process_save = (response, defaultHandler) ->
      switch response.status
        when 422 # unprocessable entity
          for field, error_list of response.data
            for error in error_list
              $log.error error
              $rootScope.notify_error "#{field} #{error}"
        else
          if defaultHandler?
            defaultHandler()
          else
            $rootScope.notify_error 'Unable to save.'

    @process_login = (response, defaultHandler) ->
      switch response.status
        when 401 # unauthorized
          $rootScope.notify_error response.data.message if "message" of response.data
        else
          if defaultHandler?
            defaultHandler()
          else
            $rootScope.notify_error 'Login failed'

    @process_registration = (response, defaultHandler) ->
      switch response.status
        when 401
          $rootScope.notify_error response.data.message if "message" of response.data
        else
          if defaultHandler?
            defaultHandler()
          else
            $rootScope.notify_error 'Registration Failed'

    @process_forgot_password = (response, defaultHandler) ->
      switch response.status
        when 401
          $rootScope.notify_error response.data.message if "message" of response.data
        else
          if defaultHandler?
            defaultHandler()
          else
            $rootScope.notify_error 'Sorry, we are unable to reset your password.'

    @ #return self
]