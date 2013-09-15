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

        $scope.hasError = (input) ->
          !input.$valid && (input.$dirty || $scope.submitted)

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
                services: Object.keys($scope.user.provider.checked_services)

              Auth.register_vendor($scope.user.vendor.email, 'local', $scope.user.vendor.email, $scope.user.vendor.password, additional_fields, provider_fields)
            else
              FormHandler.validate $scope.form.$error
          else
            $rootScope.notify_error 'Please check that you have read the terms and conditions'

        $scope.removePhoto = (index) ->
          $scope.user.provider.provider_pictures.splice(index,1)


        $scope.$on 'fileupload:add', (e, data)->
          $scope.$apply ->
            switch data.id
              when 'photo-uploader'
                $scope.photo_upload_state = 'Uploading...'


        $scope.$on 'fileupload:done', (e, data) ->
          $scope.$apply ->
            console.log 'upload result:'
            console.log data
            url = data.data.result?.data?.content?.url
            avatar_url = data.data.result?.data?.avatar?.url
            thumb_url = data.data.result?.data?.thumb?.url
            if url?
              switch data.id
                when 'photo-uploader'
                  $scope.photo_upload_state = ''
                  $scope.user.provider.provider_pictures.push
                    url: data.domain + url
                    avatar_url: data.domain + avatar_url
                    thumb_url: data.domain + thumb_url



        $scope.$on 'fileupload:failed', ->
          $scope.error_notification 'Failed to upload picture.', false


        init = ->
          console.log($scope)
          $scope.submitted = false
          $scope.user =
            vendor: {}
            provider:
              provider_pictures: []
          $scope.user.provider.checked_services = {}
          $scope.services = Service.all
            order: 'created_at ASC'
        init()
    ]
]