exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  conventions:
    # docs and i18n folders
    # node_modules folder except folder named `vendor`
    # anything prefixed by '_'
    ignored: /(docs|i18n|src|lib)(\/|\\)|(^|\/)node_modules(?!.*vendor)|(^|\/)_/
    assets: /assets(\/|\\)/
  modules:
    definition: false
    wrapper: false
  paths:
    public: 'www'

  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /vendor/
        'test/scenarios.js': /^test(\/|\\)e2e/
      order:
        before: [
          'vendor/jquery/jquery.min.js'
          'vendor/angular/angular.js'
          'vendor/angular/angular-resource.js'
          'vendor/lodash/lodash.min.js'
          'vendor/restangular/restangular.js'
          'vendor/jquery-file-upload/js/jquery.ui.widget.js'
          'vendor/jquery-file-upload/js/jquery.iframe-transport.js'
          'vendor/jquery-file-upload/js/jquery.fileupload.js'
          'app/scripts/globals.coffee'
          'app/scripts/app.coffee'
        ]

    stylesheets:
      joinTo:
        'css/app.css': /^app/
        'css/vendor.css': /vendor/

  server:
    port: 3333

# Enable or disable minifying of result js / css files.
  optimize: false
