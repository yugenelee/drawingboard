angular.module('platform').controller 'ProviderCtrl', [
  '$scope'
  'provider'
  'service'
  '$modal'
  'Cart'
  'Review'
  ($scope, provider, service, $modal, Cart, Review) ->
    $scope.provider = provider
    $scope.service = service
    $scope.reviewFormOpened = false
    $scope.provider_pictures_pairs = []
    i = 0
    while i < $scope.provider.provider_pictures.length
      first = $scope.provider.provider_pictures[i]
      second = $scope.provider.provider_pictures[i + 1]
      $scope.provider_pictures_pairs.push [first,second]
      i += 2

    $scope.all_reviews_count = Review.count()
    $scope.reviews = Review.all
      conditions:
        provider_id: provider.id
    $scope.populateReviews = ->
      $scope.reviews = Review.all
        conditions:
          provider_id: provider.id
      $scope.all_reviews_count = Review.count()

    $scope.$on 'repull_reviews', ->
      $scope.populateReviews()

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

    $scope.openQuoteDialog = ->
      if $scope.user_type == 'member'
        $modal.open
          templateUrl: 'dialogs/choose_services.dialog.html'
          windowClass: 'modal'
          controller: [
            '$scope'
            '$modalInstance'
            ($scope, $modalInstance) ->
              $scope.services = provider.services
              $scope.selected_services = {}
              $scope.cancel = ->
                $modalInstance.close()
              $scope.confirm = ->
                angular.forEach $scope.selected_services, (checked, service) ->
                  Cart.add service, provider if checked
                $modalInstance.close()
          ]
      else
        $scope.notify_info 'You need to login as member to request for quotes.'

]