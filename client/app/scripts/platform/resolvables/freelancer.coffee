resolvables['freelancer'] = [
  'Freelancer'
  '$route'
  (Freelancer, $route) ->
    id = $route.current.params['id']
    Freelancer.find id
]