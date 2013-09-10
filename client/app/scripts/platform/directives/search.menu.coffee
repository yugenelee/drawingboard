angular.module('platform').directive 'searchMenu', [
  ->
    restrict: 'E'
    templateUrl: 'partials/platform/search.menu.html'
    scope:
      name: '@'
      options: '@'
    controller: [
      '$scope'
      '$parse'
      '$attrs'
      ($scope, $parse, $attrs) ->
        name = $attrs.name
        options = $attrs.options
        OPTIONS_REGEXP = /^\s*(.*?)(?:\s+as\s+(.*?))?(?:\s+group\s+by\s+(.*))?\s+for\s+(?:([\$\w][\$\w\d]*)|(?:\(\s*([\$\w][\$\w\d]*)\s*,\s*([\$\w][\$\w\d]*)\s*\)))\s+in\s+(.*)$/
        throw Error("Expected options in form of '_select_ (as _label_)? for (_key_,)?_value_ in _collection_'" + " but got '" + options + "'.")  unless match = options.match(OPTIONS_REGEXP)
        $scope.displayFn = $parse(match[2] or match[1])
        valueName = match[4] or match[6]
        $scope.valueFn = $parse((if match[2] then match[1] else valueName))
        valuesFn = $parse(match[7])
        $scope.list = ({item: list_item} for list_item in valuesFn($scope.$parent))
        console.log name
        $scope.select = (selected) ->
          $scope.$emit 'search:menu', name: name, selected: selected
    ]
]