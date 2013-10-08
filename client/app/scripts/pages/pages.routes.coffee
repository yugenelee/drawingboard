angular.module('pages').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider.simplify($routeProvider).set_template_prefix('views/pages')
    .when('home')
    .when('about', omitController: true)
    .when('contact')
    .when('faq', omitController: true)
    .when('terms', omitController: true)
    .when('privacy', omitController: true)
    .when('blog', omitController: true)
    .when('why_list_our_business', omitController: true)
    .when('advertise', omitController: true)
    .when('newsletter', omitController: true)

  #.when('home', resolves: ['projects'])
]
