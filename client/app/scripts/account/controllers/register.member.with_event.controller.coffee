angular.module('dashboard').controller 'RegisterMemberWithEventCtrl', [
  '$scope'
  'Cart'
  'FormHandler'
  '$cookieStore'
  'Event'
  ($scope, Cart, FormHandler, $cookieStore, Event) ->

    $scope.remove = (service_name, provider_id) ->
      Cart.remove(service_name, provider_id)

    $scope.lengthOfHash = (hash) ->
      Object.keys(hash).length - 1

    $scope.saveForm = ->
      $scope.submitted = true
      if $scope.form.$valid
        $scope.clear_notifications()
        passwd = $scope.form_object['password']
        delete $scope.form_object['password']
        $cookieStore.put 'register_with_event_form', $scope.form_object
        $scope.form_object['password'] = passwd
        $scope.notify_success 'Your event details are now saved.'
      else
        FormHandler.validate $scope.form.$error

    $scope.submitForm = ->
      $scope.submitted = true
      if $scope.terms_and_conditions
        if $scope.form.$valid
          $scope.clear_notifications()
          promise = Event.submit_event_form_and_register $scope.form_object
          success_msg = 'Your request has been submitted.'
          promise.then ((object)->
            $scope.redirect_to "An email with further instruction will be sent to you shortly." ,success: success_msg
          ), ->
            $scope.notify_error 'Form has missing or invalid values'
        else
          FormHandler.validate $scope.form.$error
      else
        $scope.notify_info 'Please check that you have read the terms and conditions'

    init = ->
      FormHandler.formify $scope
      $scope.form_object = $cookieStore.get('register_with_event_form') || $cookieStore.get('event_form') || {}
      $scope.form_object.cart = Cart.get()
      if angular.isUndefined $scope.form_object.questions
        $scope.form_object.questions = {}


    init()


]