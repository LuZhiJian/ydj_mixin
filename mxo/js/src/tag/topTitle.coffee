###*
 *
 * 头部
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

{Template, Component} = require 'mcoreapp'

# 是否在微信中打开
_isWeixinBrowser = (/MicroMessenger/i).test(
    window.navigator.userAgent
)


class TopTitle extends Component
    init: ->
        # 是否在微信中打开
        @render require('../tpl/tag/topTitle.html'),
            title: ''
            isWeixinBrowser: _isWeixinBrowser

    # 后退
    back: ->
        if window.history.length > 1
            window.history.back()
        else
            window.location.href = '#/'
        return false


Template.components['top-title'] = TopTitle
