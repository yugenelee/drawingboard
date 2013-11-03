angular.module('platform').factory 'Payment', [
  'Restangular'
  '$rootScope'
  '$filter'
  'SiteUrl'
  (Restangular, $rootScope, $filter, SiteUrl) ->
    class Model extends BaseModel

      paypal_link: (provider_id, priceplan_id) ->
        pp_return_url = "#{SiteUrl}/#/paypal_success"
        pp_cancel_url = "#{SiteUrl}/#/paypal_cancelled"
        request_obj = {provider_id, priceplan_id, pp_return_url, pp_cancel_url}
        console.log(request_obj)
        @before_operation request_obj
        Restangular.all('payments').customGET 'paypal_link', request_obj, {}

      perform_payment: (token, payer_id) ->
        request_obj = {token, payer_id}
        @before_operation request_obj
        Restangular.all('payments').customPOST 'perform_payment', {}, {}, request_obj

    return new Model(Restangular, $rootScope, $filter, 'payment', 'payments')
]