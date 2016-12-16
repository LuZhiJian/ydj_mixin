# 奖品记录
# @author ciwyaitd
# @date   16/3/22
# @description []
'use strict'

weui = require 'mcore-weui'

class Prize extends require('./base')
    run: ->
        @render require('../tpl/view/prize.html'),
            prizeList: @getPrizeList()
            tech: @getSupportTech()

    getPrizeList: ->
        data = {
            open_id: @context.open_id,
            the_type: @context.the_type
        }
        @api.getPrizeList(data).then (res)=>
            res


module.exports = Prize
module.exports.viewName = 'prize'
