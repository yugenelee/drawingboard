resolvables['service'] = [
  'Service'
  '$route'
  (Service, $route) ->
    name = $route.current.params['name']
    Service.get_from_name name
]