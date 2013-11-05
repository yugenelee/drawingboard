angular.module('platform').controller 'ProviderCtrl', [
  '$scope'
  'provider'
  'service'
  '$modal'
  'Cart'
  'Review'
  '$location'
  '$anchorScroll'
  ($scope, provider, service, $modal, Cart, Review, $location, $anchorScroll) ->

    $scope.goToReviews = ->
      $location.hash('listing-reviews')
      $anchorScroll()

    $scope.provider = provider
    $scope.service = service
    $scope.requestsInCart = Cart.getRequestKeys()
    $scope.reviewFormOpened = false
    $scope.provider_pictures_pairs = []
    i = 0
    while i < $scope.provider.provider_pictures.length
      first = $scope.provider.provider_pictures[i]
      second = $scope.provider.provider_pictures[i + 1]
      $scope.provider_pictures_pairs.push [first,second]
      i += 2


    ### REVIEWS ###
    $scope.reviews_query =
      order: 'created_at DESC'
      page: 1
      per_page: 3
      conditions:
        provider_id: provider.id

    $scope.populateReviews = ->
      $scope.all_reviews_count = Review.count()
      Review.count($scope.reviews_query).then ((count) ->
        $scope.total_review_results = count
        $scope.total_review_pages = Math.ceil(count/$scope.reviews_query.per_page)
      ), ->
        $scope.notify_error 'Unable to fetch count from server'
      Review.all($scope.reviews_query).then ((reviews) ->
        $scope.reviews = reviews
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.$on 'repull_reviews', ->
      $scope.populateReviews()

    $scope.$watch 'reviews_query', (new_value, old_value, scope) ->
      if new_value.page == old_value.page
        scope.reviews_query.page = 1
      $scope.populateReviews()
    , true

    ### DIALOGS ###
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

    $scope.requestQuote = ->
      if $scope.user_type != 'vendor'
        Cart.add service.display_name, provider
        $scope.notify_success 'Request added to your cart.'
      else
        $scope.notify_info 'Vendor cannot request quotes from other vendors.'

]