angular.module('admin').controller 'AdminListingCtrl', [
  '$scope'
  '$rootScope'
  'Provider'
  ($scope, $rootScope, Provider) ->

    $scope.providers = Provider.all
      order: 'updated_at DESC'

    $scope.approve = (provider) ->
      provider.status = 'Approved'
      Provider.approve(provider.id).then ->
        $rootScope.notify_success 'approved!'
      , ->
        $rootScope.notify_error 'Unable to approve listing'

]