angular.module('platform').controller 'PaypalSuccessCtrl', [
  '$scope'
  'Payment'
  '$routeParams'
  ($scope, Payment,$routeParams) ->
    console.log $routeParams
    Payment.perform_payment($routeParams.token, $routeParams.PayerID).then (res) ->
      if res.status == 'PAYMENT_FAILED'
        $scope.redirect_to '/', error: 'Payment has failed. You have not been charged'
      else
        $scope.redirect_to 'dashboard.vendor.listing', success: 'Payment has been recorded successfully. Listing has been submitted for admin approval. Thank you.'
]