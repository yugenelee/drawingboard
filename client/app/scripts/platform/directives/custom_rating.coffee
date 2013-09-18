
# Get objects used in template
angular.module("fork").constant("customRatingConfig",
  max: 5
  stateOn: null
  stateOff: null
)

angular.module("fork").controller("CustomRatingController", ["$scope", "$attrs", "$parse", "customRatingConfig", ($scope, $attrs, $parse, ratingConfig) ->
  @maxRange = (if angular.isDefined($attrs.max) then $scope.$parent.$eval($attrs.max) else ratingConfig.max)
  @stateOn = (if angular.isDefined($attrs.stateOn) then $scope.$parent.$eval($attrs.stateOn) else ratingConfig.stateOn)
  @stateOff = (if angular.isDefined($attrs.stateOff) then $scope.$parent.$eval($attrs.stateOff) else ratingConfig.stateOff)
  @createRateObjects = (states) ->
    defaultOptions =
      stateOn: @stateOn
      stateOff: @stateOff

    i = 0
    n = states.length

    while i < n
      states[i] = angular.extend(
        index: i
      , defaultOptions, states[i])
      i++
    states

  $scope.range = (if angular.isDefined($attrs.ratingStates) then @createRateObjects(angular.copy($scope.$parent.$eval($attrs.ratingStates))) else @createRateObjects(new Array(@maxRange)))
  $scope.rate = (value) ->
    return  if $scope.readonly or $scope.value is value
    $scope.value = value

  $scope.enter = (value) ->
    $scope.val = value  unless $scope.readonly
    $scope.onHover value: value

  $scope.reset = ->
    $scope.val = angular.copy($scope.value)
    $scope.onLeave()

  $scope.$watch "value", (value) ->
    $scope.val = value

  $scope.readonly = false
  if $attrs.readonly
    $scope.$parent.$watch $parse($attrs.readonly), (value) ->
      $scope.readonly = !!value

])

angular.module("fork").directive "customRating", ->
  restrict: "EA"
  scope:
    value: "="
    onHover: "&"
    onLeave: "&"

  controller: "CustomRatingController"
  templateUrl: "template/custom_rating/custom_rating.html"
  replace: true
