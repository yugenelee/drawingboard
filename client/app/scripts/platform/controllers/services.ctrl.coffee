angular.module('platform').controller 'ServicesCtrl', [
  '$scope'
  'service'
  '$modal'
  'Cart'
  '$location'
  'Provider'
  ($scope, service, $modal, Cart, $location, Provider) ->
    $scope.service = service

    $scope.goToDetailsPage = (provider_id)->
      if $scope.user_type == 'member'
        $location.path "provider/#{ provider_id }/#{ service.name }"
      else
        $scope.notify_info 'You need to login as member first to view details and request for quotes'

    $scope.services_sort_by = (criteria) ->
      $scope.query.order = criteria

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

    init = ->
      $scope.query =
        order: 'created_at DESC'
        page: 1
        per_page: 5
        any_in:
          service_ids: [service.id]
        conditions:
          status: 'Approved'
      $scope.$watch 'query', (new_value, old_value, scope) ->
        if new_value.page == old_value.page
          scope.query.page = 1
        $scope.refreshList()
      , true
      $scope.refreshList()

    init()
]