###*
#
# @date 2016-01-29 15:44:12
# @author vfasky <vfasky@gmail.com>
# @link http://vfasky.com
###
'use strict'

class Index extends require('./base')
    run: ->
        @render require('../tpl/view/index.html'),
            summary: {}
            tech: @getSupportTech()
        .then =>
            @set 'summary', @api.getSummary().then (res)=>
              res.signup = res.three.signup
              res.vote = res.three.vote
              res.view = res.three.view
              res.start = res.start.split(' ')[0]
              res.end = res.end.split(' ')[0]
              res

module.exports = Index
module.exports.viewName = 'index'
