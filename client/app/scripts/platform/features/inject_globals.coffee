angular.module('platform').run [
  '$rootScope'
  'Cart'
  ($rootScope, Cart) ->

    $rootScope.cart = Cart

]
