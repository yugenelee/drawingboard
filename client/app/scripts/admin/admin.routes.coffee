angular.module('admin').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider
    .simplify($routeProvider)
    .set_template_prefix('views/admin')
    .when('admin.login', omitController: true)
    .when('admin.listing')
    .when('admin.events')
    .when('admin.users')
]
