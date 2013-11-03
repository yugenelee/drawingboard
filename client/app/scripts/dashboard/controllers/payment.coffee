angular.module('dashboard').controller 'DashboardPaymentCtrl', [
  '$scope'
  'provider'
  'Payment'
  ($scope, provider, Payment) ->

    $scope.provider = provider

    $scope.pay = ->
      Payment.paypal_link(provider.id, provider.priceplan.id).then (res) ->
        console.log(res)
        if res.status == 'SUCCESS'
          window.location = res.paypal_url

]