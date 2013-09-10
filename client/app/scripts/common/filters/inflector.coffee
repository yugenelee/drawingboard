###
Converts variable-esque naming conventions to something presentational, capitalized words separated by space.
@param {String} value The value to be parsed and prettified.
@param {String} [inflector] The inflector to use. Default: humanize.
@return {String}
@example {{ 'Here Is my_phoneNumber' | inflector:'humanize' }} => Here Is My Phone Number
{{ 'Here Is my_phoneNumber' | inflector:'underscore' }} => here_is_my_phone_number
{{ 'Here Is my_phoneNumber' | inflector:'variable' }} => hereIsMyPhoneNumber
###
angular.module('common').filter 'inflector', ->
  ucwords = (text) ->
    text.replace /^([a-z])|\s+([a-z])/g, ($1) ->
      $1.toUpperCase()

  breakup = (text, separator) ->
    text.replace /[A-Z]/g, (match) ->
      separator + match

  inflectors =
    humanize: (value) ->
      ucwords breakup(value, " ").split("_").join(" ")

    underscore: (value) ->
      value.substr(0, 1).toLowerCase() + breakup(value.substr(1), "_").toLowerCase().split(" ").join("_")

    variable: (value) ->
      value = value.substr(0, 1).toLowerCase() + ucwords(value.split("_").join(" ")).substr(1).split(" ").join("")
      value

  (text, inflector, separator) ->
    if inflector isnt false and angular.isString(text)
      inflector = inflector or "humanize"
      inflectors[inflector] text
    else
      text
