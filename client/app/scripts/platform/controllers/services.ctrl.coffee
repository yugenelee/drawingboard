angular.module('platform').controller 'ServicesCtrl', [
  '$scope'
  'service'
  '$modal'
  'Cart'
  '$location'
  ($scope, service, $modal, Cart, $location) ->
    $scope.service = service

    $scope.openQuoteDialog = (provider)->
      if $scope.user_type == 'member'
        $modal.open
          templateUrl: 'dialogs/choose_services.dialog.html'
          windowClass: 'modal'
          controller: [
            '$scope'
            '$modalInstance'
            ($scope, $modalInstance) ->
              $scope.services = provider.services
              console.log provider
              $scope.selected_services = {}
              $scope.cancel = ->
                $modalInstance.close()
              $scope.confirm = ->
                angular.forEach $scope.selected_services, (checked, service) ->
                  Cart.add service, provider if checked
                console.log Cart.get()
                $modalInstance.close()
          ]
      else
        $scope.notify_info 'You need to login as member to request for quotes.'

    $scope.goToDetailsPage = (provider_id)->
      if $scope.user_type == 'member'
        $location.path "provider/#{ provider_id }/#{ service.name }"
      else
        $scope.notify_info 'You need to login as member first to view details and request for quotes'

]