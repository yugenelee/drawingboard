angular.module('dashboard').controller 'DashboardPaymentCtrl', [
  '$scope'
  'provider'
  'Payment'
  'Discount'
  ($scope, provider, Payment, Discount) ->

    $scope.provider = provider
    $scope.discount = 0

    $scope.changeTrigger = ->
      Discount.is_valid_discount_code($scope.discount_code).then (response) ->
        console.log(response)
        $scope.discount = response.percentage
        $scope.newPrice = (provider.priceplan.price * (100-$scope.discount) / 100).toFixed(2)

    $scope.pay = ->
      alert($scope.discount_code)
      Payment.paypal_link(provider.id, provider.priceplan.id, $scope.discount_code).then (res) ->
        console.log(res)
        if res.status == 'SUCCESS'
          window.location = res.paypal_url

]