#
# @author ciwyaitd
# @date   16/3/23
# @description []
'use strict'

weui = require 'mcore-weui'

class GetPrize extends require('./base')
    run: ->
        @render require('../tpl/view/getPrize.html'),
            tech: @getSupportTech()

    saveWinnerInfo: (err, data) ->
        return @showValidatorErr err if err
        @api.saveContact
            open_id: @context.open_id or null
            the_type: @context.the_type or null
            receive_name: data.name
            receive_tel: data.handset
            receive_wx_code: data.wxcode
        .done =>
            weui.Dialog.alert '信息提交成功，我们的客服将会尽快联系您，每天投票都有一次抽奖机会哦，明天大奖继续等着你哦！', =>
                window.location.href = '#/prize?open_id=' + @context.open_id + '&the_type=' + @context.the_type
            , '温馨提示'

        .fail (res) =>
            weui.Dialog.alert res.response, =>
                window.location.href = '#/prize?open_id=' + @context.open_id + '&the_type=' + @context.the_type
            , '提示'



module.exports = GetPrize
module.exports.viewName = 'getPrize'
