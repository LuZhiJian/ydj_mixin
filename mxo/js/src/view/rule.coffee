###*
 *
 * 规则
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

PopQRCode = require '../ui/popQRCode'

class Rule extends require('./base')

    run: ->
        #@setTitle '大赛规则'
        @render require('../tpl/view/rule.html'),
            info: {}
            tech: @getSupportTech()
        .then =>
            @set 'info', @api.setDetail().then (res)=> res


module.exports = Rule
module.exports.viewName = 'rule'
