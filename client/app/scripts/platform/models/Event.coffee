angular.module('platform').factory 'Event', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel

      save_form: (form_object) ->
        @before_operation form_object
        Restangular.all('events').customPOST 'save_form', {}, {}, form_object

      send_quote_request: (event_id) ->
        Restangular.one('events', event_id).customPOST 'send_quote_request', {}, {}

    return new Model(Restangular, $rootScope, $filter, 'event', 'events')
]