angular.module('dashboard').controller 'DashboardEmployerProfileCtrl', [
  '$scope'
  '$rootScope'
  ($scope, $rootScope) ->

    $scope.hasError = (input) ->
      !input.$valid && (input.$dirty || $scope.submitted)

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.form.$valid
        $scope.clear_notifications()
        $rootScope.current_user.put().then ((current_user)->
          $rootScope.current_user = current_user
          $scope.notify_success 'Your profile is updated successfully'
        ), ->
          window.scrollTo(0)
          $scope.notify_error 'Form has missing or invalid values'
      else
        window.scrollTo(0)
        angular.forEach $scope.form.$error, (val, key) ->
          angular.forEach val, (inner_val) ->
            switch key
              when 'required'
                if inner_val.$error.required == true
                  $scope.notify_error "#{inner_val.$name?.humanize()} is missing."
                else if angular.isArray(inner_val.$error.required)
                  $scope.notify_error "#{inner_val.$error.required[0].$name.humanize()} is missing"
              when 'email'
                if inner_val.$error.email == true
                  $scope.notify_error "#{inner_val.$viewValue} is not a valid email."
                else if angular.isArray(inner_val.$error.email)
                  $scope.notify_error "#{inner_val.$error.email[0].$viewValue} is not a valid email."
              when 'url'
                if inner_val.$error.url == true
                  $scope.notify_error "#{inner_val.$viewValue} is not a valid url."
                else if angular.isArray(inner_val.$error.url)
                  $scope.notify_error "#{inner_val.$error.url[0].$viewValue} is not a valid url."

    init = ->
      $scope.submitted = false
    init()

]