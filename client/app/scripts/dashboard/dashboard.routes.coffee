angular.module('dashboard').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider
    .simplify($routeProvider)
    .set_template_prefix('views/dashboard')
    .require_user()
    .when('dashboard.vendor.listing')
    .when('dashboard.vendor.profile')
    .when('dashboard.member.events')
    .when('dashboard.member.cart')
]
