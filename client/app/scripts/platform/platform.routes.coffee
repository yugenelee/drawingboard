angular.module('platform').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).set_template_prefix('views/platform')
    .when('service_categories', omitController: true)
    .when('services/:name', resolves: ['service'])
]
