angular.module('admin').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider
    .simplify($routeProvider)
    .require_admin()
    .set_template_prefix('views/admin')
    .when('admin.login', omitController: true, admin: false)
    .when('admin.listing')
    .when('admin.events')
    .when('admin.users')
    .when('admin.discount_codes')
    .when('admin.discount_codes.new', omitController: true)
    .when('admin.discount_codes.edit/:id', omitController: true)
]
