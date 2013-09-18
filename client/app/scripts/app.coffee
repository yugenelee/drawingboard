angular.module 'config', []
angular.module 'fork', []
angular.module 'account', []
angular.module 'dashboard', []
angular.module 'pages', []
angular.module 'platform', []

angular.module 'common', [
  'ui.route'
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
  'account'
  'pages'
  'platform'
]

angular.element(document).ready ->
  angular.bootstrap document, ['app']