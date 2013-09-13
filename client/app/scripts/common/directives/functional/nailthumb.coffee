angular.module('common').directive 'nailthumb', [
  ->
    restrict: 'A'

    scope:
      method: '@'
      width: '@'
      height: '@'
      replaceAnimation: '@'
      ngSrc: '@'

    link: (scope, element, attrs) ->
      options =
        method: 'crop'
        width: '125'
        height: '125'
        replaceAnimation: 'fade'
      options.method = attrs.method if attrs.method?
      options.width = attrs.width if attrs.width?
      options.height = attrs.height if attrs.height?
      options.replaceAnimation = attrs.replaceAnimation if attrs.replaceAnimation?
      attrs.$observe 'ngSrc', ->
        # ensure that nailthumb is called only after
        element.nailthumb options
]