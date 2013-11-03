angular.module('account').controller 'AccountPricingCtrl', [
  '$scope'
  '$location'
  'MemoryStore'
  ($scope, $location, MemoryStore) ->

    $scope.basicPlan = ->
      MemoryStore.set('pricingplan', 'basic')
      if $scope.authenticated
        $location.path('listing.new')
      else
        $location.path 'register.vendor'

    $scope.basicPlusPlan = ->
      MemoryStore.set('pricingplan', 'basicplus')
      if $scope.authenticated
        $location.path('listing.new')
      else
        $location.path 'register.vendor'

    $scope.premiumPlan = ->
      MemoryStore.set('pricingplan', 'premium')
      if $scope.authenticated
        $location.path('listing.new')
      else
        $location.path 'register.vendor'
]