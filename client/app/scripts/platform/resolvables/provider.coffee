resolvables['provider'] = [
  'Provider'
  '$route'
  (Provider, $route) ->
    id = $route.current.params['id']
    Provider.find id
]