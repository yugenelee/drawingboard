angular.module('common').config [
  'RestangularProvider'
  'ServiceEndpoint'
  (RestangularProvider, ServiceEndpoint) ->
    RestangularProvider.setBaseUrl ServiceEndpoint
    RestangularProvider.setListTypeIsArray true

    RestangularProvider.setFullRequestInterceptor (element, operation, route, url, headers, params) ->

      if element?._deny_fields?
        for k in element._deny_fields
          delete element[k]
      {
        element
        operation
        route
        url
        headers
        params
      }

    RestangularProvider.setResponseExtractor (response, operation) ->
      response

]
