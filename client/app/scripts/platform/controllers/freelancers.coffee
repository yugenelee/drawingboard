angular.module('platform').controller 'FreelancersCtrl', [
  '$scope'
  'Freelancer'
  'job_categories'
  '$route'
  ($scope, Freelancer, job_categories, $route) ->

    $scope.$watch 'query.conditions.job_title', (new_val) ->
      angular.forEach $scope.jobTitles, (cat_value, cat_key) ->
        angular.forEach cat_value, (value) ->
          if angular.equals(new_val, value)
            $scope.current_job_category = cat_key

    $scope.$on 'search:menu', (e, result) ->
      if result.selected == false
        delete $scope.query.conditions.job_title
        $scope.current_job_title = 'All'
      else
        $scope.query.conditions.job_title = result.selected
        $scope.current_job_title = result.selected

    $scope.$on 'search:input', (e, search_text) ->
      if search_text? and search_text.length > 0
        $scope.query.search = search_text
      else
        delete $scope.query.search

    @refreshList = ->
      Freelancer.count($scope.query).then ((count) ->
        $scope.total_results = count
        $scope.total_pages = Math.ceil(count/$scope.query.per_page)
      ), ->
        $scope.notify_error 'Unable to fetch count from server'
      Freelancer.all($scope.query).then ((freelancers) ->
        $scope.freelancers = freelancers
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.clearFilters = ->
      $route.reload()

    init = =>
      $scope.jobTitles =
        Writing: _.uniq ['Scriptwriter','Writer','Copywriter','Journalist','Editor']
        Design: _.uniq ["Product Designer", "Graphic Designer", "Multimedia Designer", "Motion Graphic Designer", "Art Director", "Creative Director", "Set Designer", "Wardrode Designer", "Web Designer"]
        Production: _.uniq ["2D & 3D Animator", "Illustrator", "Video Producer", "Director", "Soundman", "Lightingman", "Videographer", "Cameraman", "Grip & Gaffer", "Production Manager", "Location Manager", "Director", "Video Editor", "3D Artist", "Photographer", "DI Artist", "Audio Producer", "Project Manager"]
        Others: _.uniq ['Voice-over Artist', 'Translator', 'Marketing', 'PR']

      $scope.current_job_title = 'All'
      $scope.current_job_category = 'All'
      $scope.query = {}
      $scope.query.search = ''
      $scope.query.page = 1
      $scope.query.per_page = 5
      $scope.query.conditions = {profile_incomplete: false}
      $scope.job_categories = job_categories
      $scope.$watch 'query', (new_value, old_value, scope) =>
        if new_value.page == old_value.page
          scope.query.page = 1
        @refreshList()
      , true
      @refreshList()

    init()
]