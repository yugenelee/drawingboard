resolvables['freelancers'] = [
  'Freelancer'
  (Freelancer) ->
    Freelancer.all
      conditions:
        profile_incomplete: false
      per_page: 8
]