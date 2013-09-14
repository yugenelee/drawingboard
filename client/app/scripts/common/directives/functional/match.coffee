angular.module('common').directive "match", ->
  require: "ngModel"
  scope:
    match: "="

  link: (scope, element, attrs, ctrl) ->
    scope.$watch (->
      combined = undefined
      combined = scope.match + "_" + ctrl.$viewValue  if scope.match or ctrl.$viewValue
      combined
    ), (value) ->
      if value
        ctrl.$parsers.unshift (viewValue) ->
          origin = scope.match
          if origin isnt viewValue
            ctrl.$setValidity "match", false
            `undefined`
          else
            ctrl.$setValidity "match", true
            viewValue


