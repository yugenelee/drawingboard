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
        init()
    ]
]