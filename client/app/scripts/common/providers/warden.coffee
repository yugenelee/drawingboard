angular.module('common').provider 'Warden', ->
  class Warden
    $get: ->
      # no-op

    simplify: (routeProvider) ->
      @routeProvider = routeProvider
      @requireUser = false
      @omitView = false
      @omitController = false
      return @

    set_template_prefix: (prefix) ->
      @templatePrefix = prefix
      if prefix[-1..-1] != '/'
        @templatePrefix += '/'
      return @

    require_user: ->
      @requireUser = true
      return @

    omit_view: ->
      @omitView = true
      return @

    omit_controller: ->
      @omitController = true
      return @

    # available options are
    #   `route`: for custom routes
    #   `user`: require user to be logged in to access this route
    #   `resolves`
    when: (route, options={}) ->
      if route[0..0] == '/'
        route = route[1..-1]
      cleanRoute = route.split('/')[0]
      controllerTokens = (token.capitalize() for token in cleanRoute.split(/\.|_/))
      routeStr = options.route || "/#{route}"
      controller = "#{controllerTokens.join('')}Ctrl"
      templateUrl = "#{@templatePrefix}#{cleanRoute}.html"

      resolves = {}
      options.user = @requireUser unless options.user?
      options.omitView = @omitView unless options.omitView?
      options.omitController = @omitController unless options.omitController?
      resolves.current_user = resolvables['current_user'] if options.user
      if options.resolves?
        resolves[resolve] = resolvables[resolve] for resolve in options.resolves
      if options.omitView
        templateUrl = 'views/pages/empty.html'
      if options.templateUrl?
        templateUrl = options.templateUrl
      if options.omitController
        @routeProvider.when routeStr, templateUrl: templateUrl, resolve: resolves
      else
        @routeProvider.when routeStr, templateUrl: templateUrl, controller: controller, resolve: resolves
      return @

  new Warden

