angular.module('account').directive 'registerVendorForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {}
    templateUrl: 'forms/account/register.vendor.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'Service'
      'FormHandler'
      'Auth'
      ($scope, $rootScope, $routeParams, Service, FormHandler, Auth) ->

        geocoder = new google.maps.Geocoder()

        $scope.submitForm = ->
          if $scope.terms_and_conditions
            $scope.submitted = true
            if $scope.form.$valid
              $rootScope.clear_notifications()
              additional_fields =
                first_name: $scope.user.vendor.first_name
                last_name: $scope.user.vendor.last_name
                mobile: $scope.user.vendor.mobile
                phone: $scope.user.vendor.phone
                role: $scope.user.vendor.role
                mailing_address: $scope.user.vendor.mailing_address
                acra_no: $scope.user.vendor.acra_no
                questions: $scope.user.vendor.questions

              provider_fields =
                name: $scope.user.provider.name
                address: $scope.user.provider.address
                map_address: $scope.user.provider.map_address
                browse_description: $scope.user.provider.browse_description
                profile_description: $scope.user.provider.profile_description
                provider_pictures: $scope.user.provider.provider_pictures

              provider_fields.service_ids = []
              angular.forEach $scope.user.provider.checked_services, (checked, id) ->
                provider_fields.service_ids.push(id) if checked

              Auth.register_vendor($scope.user.vendor.email, 'local', $scope.user.vendor.email, $scope.user.vendor.password, additional_fields, provider_fields)
            else
              FormHandler.validate $scope.form.$error
          else
            $rootScope.notify_error 'Please check that you have read the terms and conditions'

        $scope.setAsMapAddress = ->
          $scope.user.provider.map_address = $scope.suggested_address

        $scope.findCoordinate = ($event) ->
          console.log $scope.user.provider.map_address
          geocoder.geocode
            address: $scope.user.provider.map_address
          , (results, status) ->
              if status is google.maps.GeocoderStatus.OK
                $scope.locationMap.setCenter results[0].geometry.location
                $scope.locationMap.setZoom 14
              else
                console.log "Geocode was not successful for the following reason: " + status


        init = ->
          FormHandler.formify $scope
          $scope.user =
            vendor: {}
            provider:
              provider_pictures: []
          FormHandler.handleImage($scope, 'provider_picture', $scope.user.provider.provider_pictures)
          $scope.user.provider.checked_services = {}
          $scope.services = Service.all
            order: 'created_at ASC'

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