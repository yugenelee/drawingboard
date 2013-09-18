angular.module('dashboard').directive 'reviewForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {
      type: '@'
      reviewer: '='
      provider: '='
      reviewFormOpened: '='
    }
    templateUrl: 'forms/platform/review.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'FormHandler'
      'Review'
      ($scope, $rootScope, $routeParams, FormHandler, Entity) ->

        $scope.submitReview = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()
            switch $scope.type
              when 'new'
                promise = Entity.create $scope.form_object, notify_success: false
                success_msg = 'Review has been submitted'
              when 'edit'
                promise = $scope.form_object.put()
                success_msg = 'Your event is updated successfully'
            promise.then ((object)->
              $rootScope.notify_success success_msg
              $scope.closeForm()
              $scope.$emit 'repull_reviews'
            ), ->
              $rootScope.notify_error 'Form has missing or invalid values'
          else
            FormHandler.validate $scope.form.$error

        $scope.closeForm = ->
          $scope.reviewFormOpened = false
          $scope.form_object =
            reviewer_id: $scope.reviewer.id
            provider_id: $scope.provider.id
            rating: 0
            content: ''
            title: ''

        init = ->
          FormHandler.formify $scope
          switch $scope.type
            when 'new'
              $scope.form_object =
                reviewer_id: $scope.reviewer.id
                provider_id: $scope.provider.id
                rating: 0
                content: ''
                title: ''

            when 'edit'
              Entity.find($routeParams.id).then (obj) ->
                $scope.form_object = obj


        init()
    ]
]