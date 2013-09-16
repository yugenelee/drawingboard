angular.module('platform').controller 'ServicesCtrl', [
  '$scope'
  'service'
  '$modal'
  'Cart'
  ($scope, service, $modal, Cart) ->
    $scope.service = service

    $scope.openQuoteDialog = (provider)->
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
]