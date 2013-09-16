angular.module('dashboard').controller 'DashboardMemberCheckoutCtrl', [
  '$scope'
  'Cart'
  '$routeParams'
  'FormHandler'
  'Event'
  ($scope, Cart, $routeParams, FormHandler, Event) ->

    $scope.remove = (service_name, provider_id) ->
      Cart.remove(service_name, provider_id)

    $scope.lengthOfHash = (hash) ->
      Object.keys(hash).length - 1

    $scope.saveForm = ->
      $scope.submitted = true
      if $scope.terms_and_conditions
        if $scope.form.$valid
          $scope.clear_notifications()
          promise = Event.save_form $scope.form_object
          success_msg = 'Your event details are updated successfully'
          promise.then ((object)->
            $scope.redirect_to "dashboard.member.events" ,success: success_msg
          ), ->
            $scope.notify_error 'Form has missing or invalid values'
        else
          FormHandler.validate $scope.form.$error
      else
        $scope.notify_info 'Please check that you have read the terms and conditions'

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.terms_and_conditions
        if $scope.form.$valid
          $scope.clear_notifications()
          promise = Event.save_form $scope.form_object
          success_msg = 'Your request has been submitted.'
          promise.then ((object)->
            Event.send_quote_request($scope.form_object.id)
            $scope.redirect_to "dashboard.member.events" ,success: success_msg
          ), ->
            $scope.notify_error 'Form has missing or invalid values'
        else
          FormHandler.validate $scope.form.$error
      else
        $scope.notify_info 'Please check that you have read the terms and conditions'

    init = ->
      FormHandler.formify $scope
      Event.find($routeParams.event_id).then (obj) ->
        $scope.form_object = obj
        $scope.form_object.cart = Cart.get()
        $scope.form_object.contact_email = $scope.current_user.email
        if angular.isUndefined $scope.form_object.questions
          $scope.form_object.questions = {}


    init()


]