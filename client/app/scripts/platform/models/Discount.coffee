angular.module('platform').factory 'Discount', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel

      is_valid_discount_code: (discount_code) ->
        request_obj = {discount_code}
        @before_operation request_obj
        Restangular.all('discounts').customGET 'is_valid_discount_code', request_obj, {}
    return new Model(Restangular, $rootScope, $filter, 'discount', 'discounts')
]