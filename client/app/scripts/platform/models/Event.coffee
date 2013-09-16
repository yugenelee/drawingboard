angular.module('platform').factory 'Event', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel

      save_form: (form_object) ->
        @before_operation form_object
        Restangular.all('events').customPOST 'save_form', {}, {}, form_object

      submit_form: (form_object) ->
        @before_operation form_object
        Restangular.all('events').customPOST 'submit_form', {}, {}, form_object
    return new Model(Restangular, $rootScope, $filter, 'event', 'events')
]