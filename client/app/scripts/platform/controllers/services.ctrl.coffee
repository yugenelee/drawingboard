angular.module('platform').controller 'ServicesCtrl', [
  '$scope'
  'service'
  '$modal'
  'Cart'
  '$location'
  'Provider'
  ($scope, service, $modal, Cart, $location, Provider) ->
    $scope.service = service

    $scope.requestsInCart = Cart.getRequestKeys()

    $scope.goToDetailsPage = (provider_id)->
      $location.path "provider/#{ provider_id }/#{ service.name }"

    $scope.services_sort_by = (criteria) ->
      $scope.query.order = criteria

    $scope.filter_by_venue_size = (ev) ->
      fil = ev.target.innerText
      if fil == 'All'
        delete $scope.query.conditions.venue_size
      else
        $scope.query.conditions.venue_size = fil

      console.log $scope.query
      $scope.refreshList()

    $scope.refreshList = ->
      Provider.count($scope.query).then ((count) ->
        $scope.total_results = count
        $scope.total_pages = Math.ceil(count/$scope.query.per_page)
      ), ->
        $scope.notify_error 'Unable to fetch count from server'
      Provider.all($scope.query).then ((providers) ->
        $scope.providers = providers
      ), ->
        $scope.notify_error 'Unable to fetch result from server'

    $scope.requestQuote = (provider)->
      if $scope.user_type != 'vendor'
        Cart.add service.display_name, provider
        $scope.notify_success 'Request added to your cart.'
      else
        $scope.notify_info 'Vendor cannot request quotes from other vendors.'

    init = ->

      $scope.venue_sizes = [
        '1 - 50'
        '51 - 150'
        '151 - 300'
        '> 300'
      ]

      $scope.query =
        order: 'created_at DESC'
        page: 1
        per_page: 5
        conditions:
          status: 'Approved'
          service_id: service.id

      $scope.$watch 'query', (new_value, old_value, scope) ->
        if new_value.page == old_value.page
          scope.query.page = 1
        $scope.refreshList()
      , true
      $scope.refreshList()

    init()
]