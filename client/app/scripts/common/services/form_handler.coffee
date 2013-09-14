angular.module('common').service 'FormHandler', [
  '$rootScope'
  ($rootScope) ->
    
    @validate = (form_errors) ->
      window.scrollTo(0)
      angular.forEach form_errors, (val, key) ->
        angular.forEach val, (inner_val) ->
          switch key
            when 'required'
              if inner_val.$error.required == true
                $rootScope.notify_error "#{inner_val.$name?.humanize()} is missing." if inner_val.$name?
              else if angular.isArray(inner_val.$error.required)
                $rootScope.notify_error "#{inner_val.$error.required[0].$name.humanize()} is missing" if inner_val.$error.required[0].$name?
            when 'email'
              if inner_val.$error.email == true
                $rootScope.notify_error "#{inner_val.$viewValue} is not a valid email." if inner_val.$viewValue?
              else if angular.isArray(inner_val.$error.email)
                $rootScope.notify_error "#{inner_val.$error.email[0].$viewValue} is not a valid email." if inner_val.$error.email[0].$viewValue?
            when 'url'
              if inner_val.$error.url == true
                $rootScope.notify_error "#{inner_val.$viewValue} is not a valid url." if inner_val.$viewValue?
              else if angular.isArray(inner_val.$error.url)
                $rootScope.notify_error "#{inner_val.$error.url[0].$viewValue} is not a valid url." if inner_val.$error.url[0].$viewValue?

    @ #return self
]