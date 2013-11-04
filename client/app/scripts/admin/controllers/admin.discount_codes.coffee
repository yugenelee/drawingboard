angular.module('admin').controller 'AdminDiscountCodesCtrl', [
  '$scope'
  '$rootScope'
  'Discount'
  ($scope, $rootScope, Discount) ->

    $scope.models = Discount.all
      order: 'updated_at DESC'

    $scope.suspend = (model) ->
      model.state = 'suspended'
      model.put().then ->
        $rootScope.notify_success 'suspended'
      , ->
        $rootScope.notify_error 'unable to suspend coupon'

    $scope.activate = (model) ->
      model.state = 'active'
      model.put().then ->
        $rootScope.notify_success 'activated'
      , ->
        $rootScope.notify_error 'unable to activate coupon'



]