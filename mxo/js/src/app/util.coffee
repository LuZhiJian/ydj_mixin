###*
# Util
# @date 2016-12-12 10:00:00
# @author luzhijian <luzhijian24@gmail.com>
###
'use strict'

api = require './api'
config = require './config'
Cookies = require 'js-cookie'
queryString = require 'querystring'

module.exports =
  getQueryString: (name)->
    qs = window.location.href.split('?')[1]
    str = queryString.decode qs
    type = str[name]
    return type
