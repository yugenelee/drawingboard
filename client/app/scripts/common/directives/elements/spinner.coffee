angular.module('common').directive 'spinner', [
  ->
    restrict: 'E'
    replace: true
    templateUrl: 'partials/common/spinner.html'

    controller: [
      '$scope'
      ($scope) ->
        $scope.$on 'ajax_loading:started', ->
          $scope.isLoading = true
        $scope.$on 'ajax_loading:stopped', ->
          $scope.isLoading = false
    ],

    link: ->
      opts =
        lines: 12 # The number of lines to draw
        length: 7 # The length of each line
        width: 5 # The line thickness
        radius: 10 # The radius of the inner circle
        color: "#fff" # #rbg or #rrggbb
        speed: 1 # Rounds per second
        trail: 66 # Afterglow percentage
        shadow: true # Whether to render a shadow
        left: '78px'
        top: '78px'
      target = document.getElementById("spin")
      new Spinner(opts).spin(target)

]