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
    .when('dashboard.member.events', omitController: true)
    .when('dashboard.member.cart', user: false)
    .when('dashboard.member.checkout/:event_id')
    .when('dashboard.member.profile')
    .when('dashboard.payment/:id', resolves: ['provider'])
    .when('listing.new', omitController: true)
    .when('listing.edit/:id', omitController: true)
    .when('event.new', omitController: true)
    .when('event.edit/:id', omitController: true)
]
