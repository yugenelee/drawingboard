angular.module('dashboard').directive 'listingForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {
      type: '@'
      user: '='
    }
    templateUrl: 'forms/dashboard/listing.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'FormHandler'
      'Provider'
      'Service'
      '$location'
      'Priceplan'
      'MemoryStore'
      ($scope, $rootScope, $routeParams, FormHandler, Entity, Service, $location, Priceplan, MemoryStore) ->

        pricingplan = MemoryStore.get('pricingplan')

        if not pricingplan
          $location.path 'account.pricing'
        else
          $scope.pricingplan = pricingplan

        $scope.venue_sizes = [
          'All'
          '1 - 50'
          '51 - 150'
          '151 - 300'
          '> 300'
        ]
        geocoder = new google.maps.Geocoder()

        $scope.submitForm = ->
          $scope.submitted = true
          if $scope.terms_and_conditions
            if $scope.form.$valid
              $rootScope.clear_notifications()

              planSelector =
                conditions:
                  code: pricingplan
              Priceplan.all(planSelector).then (res) ->
                $scope.form_object.priceplan_id = res[0].id
                switch $scope.type
                  when 'new'
                    promise = Entity.create $scope.form_object, notify_success: false
                    success_msg = 'Listing has been submitted'
                  when 'edit'
                    promise = $scope.form_object.put()
                    success_msg = 'Your listing is updated successfully'
                promise.then ((object)->
                  $rootScope.redirect_to "dashboard.vendor.listing" ,success: success_msg
                ), ->
                  $rootScope.notify_error 'Form has missing or invalid values'
            else
              FormHandler.validate $scope.form.$error
          else
            $rootScope.notify_info 'Please check that you have read the terms and conditions'

        $scope.setAsMapAddress = ->
          $scope.form_object.map_address = $scope.suggested_address

        $scope.findCoordinate = ($event=null) ->
          console.log $scope.coord_zipcode
          if $event
            $event.preventDefault()
          geocoder.geocode
            address: $scope.coord_zipcode + ' Singapore'
          , (results, status) ->
            if status is google.maps.GeocoderStatus.OK
              $scope.locationMap.setCenter results[0].geometry.location
              $scope.locationMap.setZoom 14
              if angular.isUndefined $scope.locationMarker
                $scope.locationMarker = new google.maps.Marker(
                  map: $scope.locationMap
                  position: results[0].geometry.location
                )
              else
                $scope.locationMarker.setPosition(results[0].geometry.location)
              geocoder.geocode
                latLng: results[0].geometry.location
              , (gresults, status) ->
                if status is google.maps.GeocoderStatus.OK
                  if results[0]
                    $scope.suggested_address = gresults[0].formatted_address
                  else
                    console.log "No results found for geocoding latlng"
                else
                  console.log "Geocoder failed due to: " + status
            else
              console.log "Geocode was not successful for the following reason: " + status
          false

        init = ->
          FormHandler.formify $scope
          $scope.services = Service.all()
          switch $scope.type
            when 'new'
              $scope.form_object =
                vendor_id: $scope.user.id
                provider_pictures: []
              FormHandler.handleImage($scope, 'provider_picture', $scope.form_object.provider_pictures)

            when 'edit'
              Entity.find($routeParams.id).then (obj) ->
                $scope.form_object = obj
                FormHandler.handleImage($scope, 'provider_picture', $scope.form_object.provider_pictures)

          $scope.mapOptions =
            center: new google.maps.LatLng(1.3667, 103.8)
            zoom: 12
            mapTypeId: google.maps.MapTypeId.ROADMAP
            streetViewControl: false
            overviewMapControl: false
            panControl: false
            mapTypeControl: false

          $scope.setLocationMarker = ($event, $params) ->
            $scope.form_object.map_lat = $params[0].latLng.lat()
            $scope.form_object.map_lng = $params[0].latLng.lng()
            if angular.isUndefined $scope.locationMarker
              $scope.locationMarker = new google.maps.Marker(
                map: $scope.locationMap
                position: $params[0].latLng
              )
            else
              $scope.locationMarker.setPosition($params[0].latLng)
            geocoder.geocode
              latLng: $params[0].latLng
            , (results, status) ->
              if status is google.maps.GeocoderStatus.OK
                if results[0]
                  $scope.suggested_address = results[0].formatted_address
                else
                  console.log "No results found for geocoding latlng"
              else
                console.log "Geocoder failed due to: " + status

        init()
    ]
]