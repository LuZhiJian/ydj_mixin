###*
 *
 * base
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

mcore = require 'mcoreapp'
{View} = mcore
api = require '../app/api'
config = require '../app/config'
PopQRCode = require '../ui/popQRCode'
VoteSuc = require '../ui/voteSuc'


# load ui
UiPopover = require('mcoreExtUiPopover') mcore

class Base extends View

    beforeInit: ->
        @api = api
        @config = config

    # 显示表单错误提示
    showValidatorErr: (err)->
        if !@_uiPopover
            @_uiPopover = new UiPopover @.$el[0]

        @_uiPopover.showError err


    # 显示美美发客服二维码
    showMMFQrCode: () ->
        @popPublic = new PopPublic @el if !@popPublic
        @popPublic.show 'http://7xrqyv.com2.z0.glb.qiniucdn.com/sp/mmf-qrcode2.jpg?imageMogr2/auto-orient/format/jpg/interlace/1/thumbnail/250', true
        false

    # 投票成功弹窗
    showVoteSuc: (name) ->
        @voteSuc = new VoteSuc @el if !@voteSuc
        @voteSuc.show(name)

    # 检测关注公众号
    checkBind: ->
        data = {
            the_type: @context.the_type
            open_id: @context.open_id
        }
        @api.checkBind(data).then (res)=>
            if res.subcode == 1028
                @showQCore res.qrcode_img
                false
            res

    # 显示二维码
    showQCore: (imgUrl)->
        @popQRCode = new PopQRCode @el if !@popQRCode
        @popQRCode.show imgUrl, '长按二维码，再点击“识别图中二维码”即可进行报名'
        false

    # 获取底部技术支持
    getSupportTech: ->
        @api.getSupportTech().then (res)=> res

module.exports = Base
