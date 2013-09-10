angular.module('platform').controller 'ProjectsShowCtrl', [
  '$scope'
  'project'
  'Project'
  ($scope, project, Project) ->

    $scope.project = project
    $scope.selected_bidder_id = null

    $scope.userEmployed = project.freelancer_id == $scope.current_user.id
    $scope.userIsEmployer = project.employer_id == $scope.current_user.id
    $scope.userOffered = _.contains project.offer_ids, $scope.current_user.id
    $scope.userBidded = _.contains project.bidder_ids, $scope.current_user.id
    $scope.userCanBid = !$scope.userEmployed and !$scope.userBidded and !$scope.userOffered

    $scope.bidProject = ->
      Project.add_bidder(project.id, $scope.current_user.id).then (project) ->
        $scope.project = project
        $scope.userOffered = false
        $scope.userBidded = true
        $scope.userCanBid = false
        $scope.notify_success 'Your bid has been placed'
      , (res) ->
        console.log res
        $scope.notify_error 'Something wrong..'

    $scope.deleteProject = ->
      promise = Project.destroy project.id, delegate: true
      promise.then ->
        $scope.redirect_to 'projects', success: 'Your project is deleted'
      , ->
        $scope.notify_error 'Unable to delete this project'

    $scope.completeProject = ->
      Project.mark_as_complete(project.id).then ->
        $scope.redirect_to 'projects', success: 'Your project is now completed'
      , (error) ->
        console.log error
        $scope.notify_error error.data?.message if error.data?.message?

    $scope.acceptOffer = ->
      Project.accept_offer(project.id, $scope.current_user.id).then (project)->
        $scope.project = project
        $scope.userOffered = false
        $scope.userBidded = false
        $scope.userEmployed = true
        $scope.userCanBid = false
        $scope.notify_success 'You accepted the offer.'
      , (res) ->
        console.log res
        $scope.notify_error 'Something wrong...'

    $scope.acceptBid = (selected) ->
      console.log selected
      if selected == null
        $scope.notify_error 'Please select a bidder from the list'
      else
        Project.accept_bid(project.id, selected).then (project) ->
          $scope.project = project
          $scope.userOffered = false
          $scope.userBidded = false
          $scope.userCanBid = false
          $scope.notify_success 'You accepted the bid.'
        , (res) ->
          console.log res
          $scope.notify_error 'Something wrong...'

]