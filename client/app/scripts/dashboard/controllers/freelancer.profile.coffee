angular.module('dashboard').controller 'DashboardFreelancerProfileCtrl', [
  '$scope'
  'job_categories'
  '$rootScope'
  ($scope, job_categories, $rootScope) ->

    $scope.$watch 'current_user.job_title', (new_val) ->
      angular.forEach $scope.jobTitles, (cat_value, cat_key) ->
        angular.forEach cat_value, (value) ->
          if angular.equals(new_val, value)
            angular.forEach job_categories, (jc_val) ->
              if angular.equals(jc_val.name, cat_key)
                console.log jc_val
                $rootScope.current_user.job_category_id = jc_val.id

    $scope.select2Options =
      width: 290

    $scope.$on 'fileupload:add', ->
      $scope.$apply ->
        $scope.avatar_upload_state = 'Uploading...'

    $scope.$on 'fileupload:done', (e, data) ->
      $scope.notify_success 'Profile picture updated'
      url = data.data.result?.data?.avatar?.url
      if url?
        $scope.$apply ->
          $scope.avatar_upload_state = ''
          $rootScope.current_user.photo_url = data.domain + url
          $rootScope.current_user.put().then ((current_user) ->
            $scope.notify_success 'New profile picture saved.'
            $scope.$apply()
          ), ->
            $scope.notify_error 'Unable to change profile picture'

    $scope.$on 'fileupload:failed', ->
      $scope.notify_error 'Upload failed', false

    $scope.hasError = (input) ->
      !input.$valid && (input.$dirty || $scope.submitted)

    $scope.submitForm = ->
      $scope.submitted = true
      if $rootScope.current_user.job_category_id == null
        $scope.notify_error 'Please select your job title from the list.'
      else
        if $scope.form.$valid
          $scope.clear_notifications()
          $rootScope.current_user.put().then ((current_user)->
            $rootScope.current_user = current_user
            $scope.redirect_to "freelancers.show/#{current_user.id}", success: 'Your profile is updated successfully'
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

    $scope.removePortfolio = (index) ->
      $rootScope.current_user.portfolios.splice(index,1)

    $scope.addPortfolio = ->
      console.log($rootScope.current_user.portfolios)
      $rootScope.current_user.portfolios.push
        name: ''
        url: ''
        description: ''
      console.log($rootScope.current_user.portfolios)

    init = ->
      $scope.submitted = false
      $scope.job_categories = job_categories
      $scope.jobTitles =
        Writing: _.uniq ['Scriptwriter','Writer','Copywriter','Journalist','Editor']
        Design: _.uniq ["Product Designer", "Graphic Designer", "Multimedia Designer", "Motion Graphic Designer", "Art Director", "Creative Director", "Set Designer", "Wardrode Designer", "Web Designer"]
        Production: _.uniq ["2D & 3D Animator", "Illustrator", "Video Producer", "Director", "Soundman", "Lightingman", "Videographer", "Cameraman", "Grip & Gaffer", "Production Manager", "Location Manager", "Director", "Video Editor", "3D Artist", "Photographer", "DI Artist", "Audio Producer", "Project Manager"]
        Others: _.uniq ['Voice-over Artist', 'Translator', 'Marketing', 'PR']
      if not $rootScope.current_user.portfolios?.length > 0
        $rootScope.current_user.portfolios = []
    init()

]