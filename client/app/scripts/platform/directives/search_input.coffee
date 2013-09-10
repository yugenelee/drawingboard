angular.module('platform').directive 'searchInput', [
  '$timeout'
  ($timeout) ->
    restrict: 'A'
    controller: [
      '$scope'
      '$element'
      ($scope, $element) ->

        $scope.$on 'search:trigger', ->
          $scope.search()

        $scope.search = ->
          $scope.$emit 'search:input', $element.val()
    ]

    link: (scope, element) ->
      timer = null
      element.keyup ->
        $timeout.cancel timer
        timer = $timeout (->
          scope.search()
        ), 500
]

angular.module('platform').directive 'searchButton', [
  ->
    restrict: 'A'
    link: (scope, element) ->
      element.click ->
        scope.$emit 'search:trigger'

]