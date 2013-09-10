angular.module('pages').controller 'ContactCtrl', [
  '$scope'
  'Mailer'
  ($scope, Mailer) ->
    $scope.submitForm = ->
      console.log($scope.contact)
      Mailer.contact_us($scope.contact).then ->
        $scope.notify_success "Thank you for contacting us. We will get back to you shortly"
]