angular.module('common').config [
  '$dialogProvider'
  ($dialogProvider) ->

    $dialogProvider.options {
      backdrop: true
      dialogClass: 'modal'
      backdropClass: 'modal-backdrop'
      transitionClass: 'fade'
      triggerClass: 'in'
      dialogOpenClass: 'modal-open'
      backdropFade: true
      dialogFade: true
      keyboard: true
      backdropClick: true
      controller: [
        '$scope'
        'dialog'
        ($scope, dialog) ->
          $scope.close = (result) ->
            dialog.close result
      ]
    }
]

