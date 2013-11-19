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
      '$cookieStore'
      ($scope, $rootScope, $routeParams, FormHandler, Entity, $cookieStore) ->

        $scope.submitForm = ->
          $scope.submitted = true
          if $scope.form.$valid
            $rootScope.clear_notifications()

            switch $scope.type
              when 'new'
                promise = Entity.create $scope.form_object, notify_success: false
                success_msg = 'Event has been submitted'
                promise.then ((object)->
                  $rootScope.redirect_to "dashboard.member.events" ,success: success_msg
                ), ->
                  $rootScope.notify_error 'Form has missing or invalid values'
              when 'edit'
                promise = $scope.form_object.put()
                success_msg = 'Your event is updated successfully'
                promise.then ((object)->
                  $rootScope.redirect_to "dashboard.member.events" ,success: success_msg
                  ), ->
                  $rootScope.notify_error 'Form has missing or invalid values'
              when 'to_cache'
                $cookieStore.put 'event_form', $scope.form_object
                $rootScope.redirect_to 'services/venues', success: 'You are now ready to start browsing and select vendors for quotes.'

          else
            FormHandler.validate $scope.form.$error

        init = ->
          FormHandler.formify $scope
          switch $scope.type
            when 'new'
              $scope.form_object = $cookieStore.get('event_form') || {}
              $scope.form_object.member_id = $scope.user.id
              $cookieStore.remove 'event_form'

            when 'edit'
              Entity.find($routeParams.id).then (obj) ->
                $scope.form_object = obj

            when 'to_cache'
              $scope.form_object = {}

        init()
    ]
]