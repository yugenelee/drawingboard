angular.module('admin').directive 'adminDiscountCodesForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {
      type: '@'
    }
    templateUrl: 'forms/admin/discount_codes.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'FormHandler'
      'Discount'
      ($scope, $rootScope, $routeParams, FormHandler, Entity) ->

        entityName = 'Discount code'
        listingPath = 'admin.discount_codes'

        $scope.submitForm = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()

            switch $scope.type
              when 'new'
                Entity.create $scope.form_object, redirect_to: listingPath, process_error: true
              when 'edit'
                promise = $scope.form_object.put()
                success_msg = "#{entityName} updated successfully"
                promise.then ((object)->
                  console.log object
                  $rootScope.redirect_to listingPath ,success: success_msg
                ), ->
                  $rootScope.notify_error 'Form has missing or invalid values'

          else
            FormHandler.validate $scope.form.$error

        init = ->
          FormHandler.formify $scope
          switch $scope.type
            when 'new'
              $scope.form_object = {}

            when 'edit'
              Entity.find($routeParams.id).then (obj) ->
                $scope.form_object = obj

        init()
    ]
]