angular.module('platform').controller 'ProviderCtrl', [
  '$scope'
  'provider'
  'service'
  '$modal'
  ($scope, provider, service, $modal) ->
    $scope.provider = provider
    $scope.service = service
    $scope.provider_pictures_pairs = []
    i = 0
    while i < $scope.provider.provider_pictures.length
      first = $scope.provider.provider_pictures[i]
      second = $scope.provider.provider_pictures[i + 1]
      $scope.provider_pictures_pairs.push [first,second]
      i += 2

    $scope.openPictureDialog = (url) ->
      $modal.open
        templateUrl: 'dialogs/provider_picture.dialog.html'
        windowClass: 'modal-img modal'
        controller: [
          '$scope'
          '$modalInstance'
          ($scope, $modalInstance) ->
            $scope.picture_url = url
            $scope.close = ->
              $modalInstance.close()
        ]

]