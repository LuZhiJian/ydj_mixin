###*
 *
 * 注入微信
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

$ = require 'jquery'
isInitWx = false
util = require '../app/util'
api = require '../app/api'

# 是否在微信中打开
_isWeixinBrowser = (/MicroMessenger/i).test(
    window.navigator.userAgent
)

_the_type = util.getQueryString 'the_type'

# defShareData =
#     title: ""
#     desc: "赶快报名，赢大奖吧！！"
#     link: window.location.href.split('#')[0] + '#/'
#     imgUrl: ''

module.exports = (err, next)->
    return next err if err

    return next() if false == _isWeixinBrowser
    defShareData = {}
    api.getSummary().done (res)=>
        defShareData.title = res.title
        defShareData.desc = "赶快报名，赢大奖吧！！"
        defShareData.link = window.location.href.split('#')[0] + '#/'
        defShareData.imgUrl = res.banner

        if isInitWx
            # 默认分享
            if @app.wxShare
                @app.wxShare defShareData

            return next()

        sUrl = 'http://ydjwxg.yidejia.com/index.php?m=mfvote&c=setting&a=jsconfig&the_type=' + _the_type

        $.getScript(sUrl).then =>

            wx.ready =>
                @app.wx = wx
                wx.hideAllNonBaseMenuItem()
                wx.showMenuItems
                    menuList: [
                        'menuItem:share:appMessage'
                        'menuItem:share:timeline'
                    ]

                # 定义微信分享
                @app.wxShare = (data, callback = ->)->
                    wx.onMenuShareTimeline
                        title: data.title
                        link: data.link
                        imgUrl: data.imgUrl
                        success: -> callback true
                        cancel: -> callback false

                    wx.onMenuShareAppMessage
                        title: data.title
                        link: data.link
                        imgUrl: data.imgUrl
                        desc: data.desc
                        success: -> callback true
                        cancel: -> callback false


                @app.wxShare defShareData

                # 隐藏右上角菜单接口
                #wx.hideOptionMenu()
                isInitWx = true
                next()

            wx.error (res)->
                isInitWx = true
                next()

        .fail ->
            isInitWx = true
            next()
