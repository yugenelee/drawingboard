angular.module 'config', []
angular.module 'fork', []
angular.module 'account', []
angular.module 'admin', []
angular.module 'dashboard', ['ui.map']
angular.module 'pages', []
angular.module 'platform', []

angular.module 'common', [
  'ui.route'
  'ui.event'
  'ui.map'
  'config'
  'fork'
  #'ngRoute'
  #'ngTouch'
  #'ngAnimate'
  'ngCookies'
  'restangular'
  'ui.bootstrap'
  'ui.select2'
]

angular.module 'app', [
  'config'
  'common'
  'dashboard'
  'admin'
  'account'
  'pages'
  'platform'
]
onGoogleReady = ->
  angular.element(document).ready ->
    angular.bootstrap document, ['app']