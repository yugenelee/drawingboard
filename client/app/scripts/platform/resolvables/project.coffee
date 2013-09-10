resolvables['project'] = [
  '$q'
  'Project'
  '$route'
  '$rootScope'
  ($q, Project, $route, $rootScope) ->
    id = $route.current.params['id']
    promise = Project.find id, delegate: true
    promise.then (project) ->
      project
    , (error) ->
      $rootScope.redirect_to 'projects', error: 'Project cannot be found'
      $q.reject error
]