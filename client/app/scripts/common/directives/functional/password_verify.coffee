angular.module('common').directive "passwordVerify", ->
  require: "ngModel"
  scope:
    passwordVerify: "="

  link: (scope, element, attrs, ctrl) ->
    scope.$watch (->
      combined = undefined
      combined = scope.passwordVerify + "_" + ctrl.$viewValue  if scope.passwordVerify or ctrl.$viewValue
      combined
    ), (value) ->
      if value
        ctrl.$parsers.unshift (viewValue) ->
          origin = scope.passwordVerify
          if origin isnt viewValue
            ctrl.$setValidity "passwordVerify", false
            `undefined`
          else
            ctrl.$setValidity "passwordVerify", true
            viewValue


