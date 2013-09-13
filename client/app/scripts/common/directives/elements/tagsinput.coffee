angular.module('common').directive 'tagsinput', [
  ->
    restrict: 'A'
    require: '?ngModel'

    link: (scope, element, attrs, ngModel) ->
      return unless ngModel

      initialized = false

      options =
        onChange: ->
          read()

      read = ->
        ngModel.$setViewValue element.val()

      ngModel.$render = ->
        if angular.isString(ngModel.$viewValue)
          element.val ngModel.$viewValue
          element.attr 'value', ngModel.$viewValue
        if not initialized
          element.tagsInput options
          initialized = true
]
