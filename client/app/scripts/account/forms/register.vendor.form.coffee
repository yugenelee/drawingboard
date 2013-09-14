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
      'Vendor'
      'Service'
      'FormHandler'
      ($scope, $rootScope, $routeParams, Vendor, Service, FormHandler) ->

        $scope.hasError = (input) ->
          !input.$valid && (input.$dirty || $scope.submitted)

        $scope.submitForm = ->
          if $scope.terms_and_conditions
            $scope.submitted = true
            if $scope.form.$valid
              $rootScope.clear_notifications()
              $rootScope.notify_success 'ok!'
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