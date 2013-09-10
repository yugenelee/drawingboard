angular.module('platform').factory 'Project', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
      add_bidder: (project_id, user_id) ->
        Restangular.one('projects', project_id).customPOST 'add_bidder', {user_id}
      add_offer: (project_id, user_id) ->
        Restangular.one('projects', project_id).customPOST 'add_offer', {user_id}
      accept_offer: (project_id, user_id) ->
        Restangular.one('projects', project_id).customPOST 'accept_offer', {user_id}
      accept_bid: (project_id, user_id) ->
        Restangular.one('projects', project_id).customPOST 'accept_bid', {user_id}
      mark_as_complete: (project_id) ->
        Restangular.one('projects', project_id).customPUT 'mark_as_complete'
    return new Model(Restangular, $rootScope, $filter, 'project', 'projects')
]