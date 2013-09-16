angular.module('dashboard').directive 'eventForm', [
  ->
    restrict: 'EA'
    replace: true
    scope: {
      type: '@'
      user: '='
    }
    templateUrl: 'forms/dashboard/event.form.html'
    controller: [
      '$scope'
      '$rootScope'
      '$routeParams'
      'FormHandler'
      'Event'
      ($scope, $rootScope, $routeParams, FormHandler, Entity) ->

        $scope.submitForm = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()

            switch $scope.type
              when 'new'
                promise = Entity.create $scope.form_object, notify_success: false
                success_msg = 'Event has been submitted'
              when 'edit'
                promise = $scope.form_object.put()
                success_msg = 'Your event is updated successfully'
            promise.then ((object)->
              $rootScope.redirect_to "dashboard.member.events" ,success: success_msg
            ), ->
              $rootScope.notify_error 'Form has missing or invalid values'
          else
            FormHandler.validate $scope.form.$error

        init = ->
          FormHandler.formify $scope
          switch $scope.type
            when 'new'
              $scope.form_object =
                member_id: $scope.user.id

            when 'edit'
              Entity.find($routeParams.id).then (obj) ->
                $scope.form_object = obj


        init()
    ]
]