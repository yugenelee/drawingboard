angular.module('platform').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).set_template_prefix('views/platform')
    #.when('service_categories', omitController: true)
    .when('services/:service_name', resolves: ['service'])
    .when('provider/:id', resolves: ['provider', 'service'])
    .when('provider/:id/:service_name', resolves: ['provider', 'service'])
    .when('paypal_success', omitView: true)
    .when('paypal_cancelled', omitView: true)
]
