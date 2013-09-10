angular.module('pages').factory 'Mailer', [
  'Restangular'
  '$rootScope'
  (Restangular) ->
    class Mailer

      contact_us: (form_values) ->
        Restangular.all('mailer').customPOST 'contact_us', {form_values}

    return new Mailer
]