angular.module('platform').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).set_template_prefix('views/platform')
    .when('projects.show/:id', resolves: ['project'])
    .when('projects', resolves: ['job_categories'])
    .when('freelancers.show/:id', resolves: ['freelancer'])
    .when('freelancers', resolves: ['job_categories'])
]
