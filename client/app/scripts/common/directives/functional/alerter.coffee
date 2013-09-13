angular.module('common').directive 'alerter', [
  ->
    restrict: 'E'
    replace: true
    scope:
      closeCountDown: '@'
    controller: [
      '$scope'
      '$timeout'
      ($scope, $timeout) ->
        $scope.alerts = []

        stack_topright =
          dir1: "down"
          dir2: "left"
          push: "top"
          spacing1: 25
          spacing2: 25
          firstpos1: 125
          firstpos2: 25

        clearAlertTimeout = null
        $scope.addAlert = (type, message)->
          _alerts = (alert.msg for alert in $scope.alerts)
          return if _alerts.indexOf(message) >= 0
          $scope.alerts.push type: type, msg: message
          $.pnotify(
            text: message
            type: type
            stack: stack_topright
          )
          $timeout.cancel(clearAlertTimeout) if clearAlertTimeout?

          _closeCountDown = 3000
          if angular.isDefined($scope.closeCountDown)
            _closeCountDown = $scope.closeCountDown
          clearAlertTimeout = $timeout (->
            $scope.clearAlerts()
          ), _closeCountDown

        $scope.clearAlerts = ->
          $scope.alerts = []
          $.pnotify_remove_all()

        ### hook to notification event ###

        $scope.$on 'notification:info', (e, msg) ->
          $scope.addAlert 'info', msg

        $scope.$on 'notification:success', (e, msg) ->
          $scope.addAlert 'success', msg

        $scope.$on 'notification:error', (e, msg) ->
          $scope.addAlert 'error', msg

        $scope.$on 'notification:clear', ->
          $scope.clearAlerts()
    ]
]