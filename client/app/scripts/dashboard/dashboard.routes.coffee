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
    .when('dashboard.member.profile')
    .when('listing.new', omitController: true)
    .when('listing.edit/:id', omitController: true)
    .when('event.new', omitController: true)
    .when('event.edit/:id', omitController: true)
]
