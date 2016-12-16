###*
 *
 * qrcode 弹窗
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

{Component} = require 'mcoreapp'

class PopQRCode extends Component
    hide: ->
        @scope.isShow = false

    show: (imgUrl, hideTip)->
        @scope.imgUrl = imgUrl
        @scope.hideTip = false
        if hideTip == true
            @scope.hideTip = true
        else
            @scope.tip = hideTip or '长按二维码，再点击“识别图中二维码”即可完成投票'
        @scope.isShow = true
        @render require('../tpl/ui/popQRCode.html')


module.exports = PopQRCode
