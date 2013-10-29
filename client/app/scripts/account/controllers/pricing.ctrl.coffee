angular.module('account').controller 'AccountPricingCtrl', [
  '$scope'
  '$location'
  'MemoryStore'
  ($scope, $location, MemoryStore) ->

    $scope.basicPlan = ->
      MemoryStore.set('pricingplan', 'basic')
      $location.path 'register.vendor'

    $scope.basicPlusPlan = ->
      MemoryStore.set('pricingplan', 'basicPlus')
      $location.path 'register.vendor'

    $scope.premiumPlan = ->
      MemoryStore.set('pricingplan', 'premium')
      $location.path 'register.vendor'

]