###*
# 大轮盘抽奖
# @author ciwyaitd
# @date   16/3/21
# @description []
###
'use strict'

weui = require 'mcore-weui'
{Router} = require 'mcoreapp'
PopQRCode = require '../ui/popQRCode'


class Lottery extends require('./base')
    run: ->
        @render require('../tpl/view/lottery.html'),
            rotate: 36
            openId: @context.open_id or null
            haveContact: 'getPrize'
            rotating: false
            prizeList: @api.getAllPrizeList().then (res) -> res
            checkLottery: @checkLottery()
            tech: @getSupportTech()
        .then =>
            @set 'haveContact', @api.getContact( open_id: @context.open_id ) .then (res) =>
                    return 'prize' if res.receive_created?
                    'getPrize'
        .then =>

    # 检测是否显示抽奖按钮
    checkLottery: ->
        data = {
            open_id: @context.open_id,
            the_type: @context.the_type
        }
        @api.checkLotteryCount(data).then (res)=>
            res

    # 每72度为一个中奖区域
    startLottery: (event, el, status, txt) ->
        if !@context.open_id
            @checkBind()
        else
            if status == 'n'
                weui.Dialog.alert txt
                return false
            else
              return if @scope.rotating

              prize =
                  [
                      '一等奖'
                      '二等奖'
                      '三等奖'
                      '四等奖'
                      '五等奖'
                  ]
              isWin = false

              @api.startLottery
                  open_id: @context.open_id
                  the_type: @context.the_type
              .done (res) =>
                  prize.map (v, i) =>
                      if (i+1) == res.prize_id
                          @scope.rotating = true
                          isWin = true
                          @scope.rotate = 3960 - (i * 72)
                          setTimeout =>
                              @scope.rotating = false
                              weui.Dialog.alert "恭喜您，抽中了#{res.prize_name}，赶紧去领取吧！", =>
                                  @api.getContact
                                      open_id: @context.open_id
                                      the_type: @context.the_type
                                  .done =>
                                      window.location.href = '#/prize?open_id=' + @context.open_id + '&the_type=' + @context.the_type
                                  .fail =>
                                      window.location.href = '#/getPrize?open_id=' + @context.open_id + '&the_type=' + @context.the_type

                              , '去领取'
                          , 6500
                          return false
                  # 不中奖
                  if !isWin
                      @scope.rotating = true
                      random = Math.ceil Math.random()*11
                      rotateDeg = if random % 2 is 0 then random + 1  else random
                      @scope.rotate = 3960 - rotateDeg*36
                      setTimeout =>
                          @scope.rotating = false
                          weui.Dialog.alert "很遗憾，您没有中奖！"
                      , 6500


module.exports = Lottery
module.exports.viewName = 'lottery'
