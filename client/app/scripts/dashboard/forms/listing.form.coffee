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
      ($scope, $rootScope, $routeParams, FormHandler, Entity, Service) ->

        $scope.submitForm = ->
          $scope.submitted = true
          if $scope.terms_and_conditions
            if $scope.form.$valid
              $rootScope.clear_notifications()

              $scope.form_object.service_ids = []
              angular.forEach $scope.form_object.checked_services, (checked, id) ->
                $scope.form_object.service_ids.push(id) if checked
              delete $scope.form_object.services

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

        init = ->
          FormHandler.formify $scope
          $scope.services = Service.all()
          switch $scope.type
            when 'new'
              $scope.form_object =
                vendor_id: $scope.user.id
                provider_pictures: []
                checked_services: {}
              FormHandler.handleImage($scope, 'provider_picture', $scope.form_object.provider_pictures)

            when 'edit'
              Entity.find($routeParams.id).then (obj) ->
                $scope.form_object = obj
                $scope.form_object.checked_services = {}
                angular.forEach obj.services, (input) -> $scope.form_object.checked_services[input.id] = true
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
        init()
    ]
]