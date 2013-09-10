angular.module('common').directive 'fileupload', [
  ->
    restrict: 'A'
    scope:
      uploaderId: '@'
      serverDomain: '@'
      servicePath: '@'

    link: (scope, element, attrs) ->
      options =
        url: "#{attrs.serverDomain}/#{attrs.servicePath}"
        dataType: 'json'
        add: (e,data) ->
          scope.$emit 'fileupload:add',
            id: attrs.uploaderId, domain: attrs.serverDomain, path: attrs.servicePath, data: data
          data.submit()
        done: (e, data) ->
          scope.$emit 'fileupload:done',
            id: attrs.uploaderId, domain: attrs.serverDomain, path: attrs.servicePath, data: data
        progress: (e, data) ->
          scope.$emit 'fileupload:progress',
            id: attrs.uploaderId, domain: attrs.serverDomain, path: attrs.servicePath, data: data
        fail: (e, data) ->
          scope.$emit 'fileupload:fail',
            id: attrs.uploaderId, domain: attrs.serverDomain, path: attrs.servicePath, data: data
      element.fileupload options
]