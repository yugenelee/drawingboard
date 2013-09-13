angular.module('pages').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).set_template_prefix('views/pages')
    .when('home')
    .when('about', omitController: true)
    .when('contact')
    #.when('home', resolves: ['projects'])
]
