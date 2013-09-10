angular.module('platform').controller 'FreelancersShowCtrl', [
  '$scope'
  'freelancer'
  'Project'
  ($scope, freelancer, Project) ->
    $scope.freelancer = freelancer

    $scope.offerProject = ->
      Project.add_offer($scope.offering_project_id, freelancer.id).then (res)->
        console.log res
        $scope.notify_success 'Project offered'
      , (response) ->
        console.log response
        alert 'fai'
]