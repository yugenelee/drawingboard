resolvables['service'] = [
  'Service'
  '$route'
  (Service, $route) ->
    name = $route.current.params['service_name']
    if name
      Service.get_from_name name
    else
      null
]