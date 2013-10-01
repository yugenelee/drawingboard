angular.module('account').config [
  '$routeProvider'
  'WardenProvider'
  ($routeProvider, WardenProvider) ->

    WardenProvider
    .simplify($routeProvider)
    .set_template_prefix('views/account')
    .omit_controller()
    .when('login')
    .when('register.member')
    .when('register.member.with_event', omitController: false)
    .when('register.vendor')
    .when('forgot_password')
    .when('reset_password/:userId/:token')
    .when('account.email_confirmation/:userId/:token', omitView: true, omitController: false)
]
