angular.module('platform').controller 'ProjectsCtrl', [
  '$scope'
  'Project'
  'job_categories'
  '$route'
  ($scope, Project, job_categories, $route) ->

    $scope.$on 'search:menu', (e, result) ->
      switch result.name
        when 'job_categories'
          if result.selected == false
            delete $scope.query.conditions.job_category_id
            $scope.current_job_category = 'All'
          else
            $scope.query.conditions.job_category_id = result.selected.id
            $scope.current_job_category = result.selected.name
        when 'budget_range'
          if result.selected == false
            delete $scope.query.conditions.budget_range
          else
            $scope.query.conditions.budget_range = result.selected

    $scope.$on 'search:input', (e, search_text) ->
      if search_text? and search_text.length > 0
        $scope.query.search = search_text
      else
        delete $scope.query.search

    @refreshList = ->
      Project.count($scope.query).then ((count) ->
        $scope.total_results = count
        $scope.total_pages = Math.ceil(count/$scope.query.per_page)
      ), ->
        $scope.notify_error 'Unable to fetch count from server'
      Project.all($scope.query).then ((projects) ->
        $scope.projects = projects
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.clearFilters = ->
      $route.reload()

    init = =>
      $scope.current_job_category = 'All'
      $scope.budget_ranges = [
        'S$0 - S$500'
        'S$500 - S$1000'
        'S$1000 - S$2000'
        'S$2000 - S$3000'
        'S$3000 - S$5000'
        'S$5000 - S$10000'
      ]
      $scope.query = {}
      $scope.query.search = ''
      $scope.query.page = 1
      $scope.query.per_page = 5
      $scope.query.conditions =
        project_status: 'project_pending'
      $scope.job_categories = job_categories
      $scope.$watch 'query', (new_value, old_value, scope) =>
        if new_value.page == old_value.page
          scope.query.page = 1
        @refreshList()
      , true
      @refreshList()

    init()
]