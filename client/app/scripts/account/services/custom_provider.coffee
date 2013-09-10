angular.module('account').factory 'CustomProvider', [
  'Auth'
  'User'
  '$rootScope'
  'MemoryStore'
  '$timeout'
  (Auth, User, $rootScope, MemoryStore, $timeout) ->
    class CustomProvider
      connectFailure = ->
        $rootScope.notify_error 'You need to authorize this app in order to log in'

      authenticate_with_custom_provider = (info) ->
        $timeout ( ->
          promise = User.get_from_account(info.user_class, info.auth_id, info.auth_provider)
          promise.then ->
            MemoryStore.set('auth_info', info)
            $rootScope.redirect_to "#{info.user_type}.login.custom_provider"
          , ->
            MemoryStore.set('auth_info', info)
            $rootScope.redirect_to "#{info.user_type}.register.custom_provider"
        ), 100

      facebookCallback = (response, user_class, user_type) ->
        if response.authResponse
          FB.api "/me", (response) ->
            authenticate_with_custom_provider {
              user_class: user_class
              user_type: user_type
              auth_id: response.id
              auth_provider: 'facebook'
              email: response.email
              additional_fields: {
                first_name: response.first_name
                last_name: response.last_name
                location: response.location?.name
                photo_url: "http://graph.facebook.com/#{response.id}/picture"
              }
            }
        else
          connectFailure()

      linkedInCallback = (user_class, user_type) ->
        IN.API.Profile('me')
        .fields('id', 'email-address','first-name', 'last-name', 'location', 'summary', 'specialties', 'positions',
            'picture-url', 'public-profile-url', 'skills', 'certifications', 'educations',
            'date-of-birth', 'three-current-positions')
        .result (result) ->
          fields = {
            user_class: user_class
            user_type: user_type
            auth_id: result.values[0].emailAddress
            auth_provider: 'linkedin'
            email: result.values[0].emailAddress
            additional_fields: {
              first_name: result.values[0].firstName
              last_name: result.values[0].lastName
              photo_url: result.values[0].pictureUrl
              location: result.values[0].location?.name
            }
          }
          if user_type == 'freelancer'
            fields.additional_fields.job_title = result.values[0].threeCurrentPositions?.values?[0]?.title
            fields.additional_fields.professional_history = result.values[0].threeCurrentPositions?.values?[0]?.summary
            fields.additional_fields.other_information = result.values[0].summary
          IN.API.Raw('/people/~/picture-urls::(original)').result (res) ->
            fields.additional_fields.photo_url = res.values[0]
          authenticate_with_custom_provider fields

      connect: (providerName, user_class, user_type) ->
        $rootScope.start_ajax()
        $timeout ->
          switch(providerName)
            when 'facebook'
              FB.login ( (response)->
                facebookCallback(response, user_class, user_type)
              ), scope: 'email, user_about_me, user_location, publish_actions'
            when 'linkedin'
              if IN.User?.isAuthorized()
                linkedInCallback(user_class, user_type)
              else
                IN.User.authorize()
                IN.Event.on IN, 'auth', ->
                  linkedInCallback(user_class, user_type)
        , 100

    return new CustomProvider
]