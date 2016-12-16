###*
 *
 * 在连接中，加入get参数
 * @author vfasky <vfasky@gmail.com>
###
'use strict'
{Template, Route} = require 'mcoreapp'

Template.formatters['urlJoin'] =  (url, args...)->
    if args.length == 0
        args.push 'open_id'
        args.push 'the_type'

    link = '?'
    link = '&' if url.indexOf('?') != -1

    urlObject = Route.pathToObject window.location.hash

    index = 0
    for v in args
        if index > 0 or url.indexOf('?') != -1
            link = '&'
        else
            link = '?'
        if urlObject[v] and String(urlObject[v]) != 'undefined'
            url += link + v + '=' + encodeURIComponent urlObject[v]
            index++
    url
