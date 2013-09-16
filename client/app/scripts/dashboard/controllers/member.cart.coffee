angular.module('dashboard').controller 'DashboardMemberCartCtrl', [
  '$scope'
  'Cart'
  ($scope, Cart) ->

    $scope.cart = Cart.get()

    $scope.remove = (service_name, provider_id) ->
      Cart.remove(service_name, provider_id)

    $scope.lengthOfHash = (hash) ->
      Object.keys(hash).length - 1
]