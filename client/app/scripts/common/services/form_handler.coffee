angular.module('common').service 'FormHandler', [
  '$rootScope'
  ($rootScope) ->

    @formify = (scope) ->
      scope.submitted = false
      scope.form_object = {}
      scope.hasError = (input) ->
        !input.$valid && (input.$dirty || scope.submitted)
      scope.removeAssoc = (assoc, index) ->
        if assoc[index].id?
          assoc[index]._destroy = true
        else
          assoc.splice(index, 1)
    
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

    @handleImage = (scope, uploader_id, receiver, uploading_msg = "Uploading..", upload_failed_msg = "Failed to upload picture.") ->
      scope.$on 'fileupload:add', (e, data)->
        scope.$apply ->
          switch data.id
            when uploader_id
              scope["#{uploader_id}_state"] = uploading_msg
      scope.$on 'fileupload:done', (e, data) ->
        scope.$apply ->
          url = data.data.result?.data?.content?.url
          avatar_url = data.data.result?.data?.avatar?.url
          thumb_url = data.data.result?.data?.thumb?.url
          if url?
            switch data.id
              when uploader_id
                scope["#{uploader_id}_state"] = ''
                receiver.push
                  url: data.domain + url
                  avatar_url: data.domain + avatar_url
                  thumb_url: data.domain + thumb_url
      scope.$on 'fileupload:failed', ->
        $rootScope.notify_error upload_failed_msg, false

    @ #return self
]