class BaseModel
  constructor: (@Restangular, @$rootScope, @$filter, @singularName, @pluralName) ->
    @humanizedSingularName = @$filter('inflector')(@singularName, 'humanize')
    @humanizedPluralName = @$filter('inflector')(@pluralName, 'humanize')

  before_operation: (event) ->
    @$rootScope.$broadcast('ajax_loading:started')

  operation_success: (event) ->
    @$rootScope.$broadcast('ajax_loading:stopped')

  operation_failed: (event) ->
    @$rootScope.$broadcast('ajax_loading:stopped')

  create: (model, options={}) ->
    @before_operation {model, options}
    promise = @Restangular.all(@pluralName).post(model)
    if options.delegate? and options.delegate
      promise
    else
      opts =
        notify_success: true
        notify_error: true
      opts.notify_success = options.notify_success if options.notify_success?
      opts.notify_error = options.notify_error if options.notify_error?
      promise.then ((item)=>
        @operation_success {item}
        @$rootScope.notify_success "#{@humanizedSingularName} created successfully" if opts.notify_success
        item
      ), (response) =>
        @operation_failed {response, model, options}
        @$rootScope.notify_error "Failed to create #{@humanizedSingularName}" if opts.notify_error
        console.log '@create error: '
        console.log response

  count: (options={}) ->
    @before_operation {options}
    queries = {}
    queries.conditions = JSON.stringify(options.conditions) if options.conditions?
    queries.search = options.search if options.search?
    promise = @Restangular.all(@pluralName).customGET('count', queries)
    if options.delegate? and options.delegate
      promise
    else
      promise.then ((count)=>
        @operation_success {count}
        count
      ), (response) =>
        @operation_failed {response, options}
        console.log '@count error:'
        console.log response

  all: (options={}) ->
    @before_operation {options}
    queries =
      limit: 1000
      offset: 0
      order: 'created_at DESC'
      page: 1
      per_page: 100
    queries.limit = options.limit if options.limit?
    queries.offset = options.offset if options.offset?
    queries.order = options.order if options.order?
    queries.page = options.page if options.page?
    queries.per_page = options.per_page if options.per_page?
    queries.includes = JSON.stringify(options.includes) if options.includes?
    queries.conditions = JSON.stringify(options.conditions) if options.conditions?
    queries.search = options.search if options.search?
    promise = @Restangular.all(@pluralName).getList(queries)
    if options.delegate? and options.delegate
      promise
    else
      promise.then ((list)=>
        @operation_success {list}
        list
      ), (response) =>
        @operation_failed {response, options}
        console.log '@all error:'
        console.log response

  find: (id, options={}) ->
    @before_operation {id, options}
    queries = {}
    queries.includes = JSON.stringify(options.includes) if options.includes?
    promise = @Restangular.one(@pluralName, id).get(queries)
    if options.delegate? and options.delegate
      promise
    else
      promise.then ((item) =>
        @operation_success {item}
        item
      ), (response) =>
        @operation_failed {response}
        @$rootScope.notify_error "Unable to find #{@humanizedSingularName}"
        console.log '@find error'
        console.log response

  destroy: (id, options={}) ->
    @before_operation {id, options}
    console.log id
    console.log @Restangular.one(@pluralName, id).remove
    promise = @Restangular.one(@pluralName, id).remove()
    if options.delegate? and options.delegate
      promise
    else
      promise.then ((item) =>
        @operation_success {item}
      ), (response) =>
        @operation_failed {response}
        @$rootScope.notify_error "Unable to delete #{@humanizedSingularName}"
        console.log '@destroy error'
        console.log response
