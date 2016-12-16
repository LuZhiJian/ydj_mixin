###*
 *
 * 底部按钮
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

{Template, Component} = require 'mcoreapp'

class FootBtn extends Component
    init: ->
        hash = String(window.location.hash).split('?').shift() or '#/'

        menu = [
            {
                title: '首页'
                icon: 's_index'
                iconTxt: '&#xe60d;'
                url: '#/'
                active: false
            }
            {
                title: '排行'
                icon: 's_ranking'
                iconTxt: '&#xe602;'
                url: '#/list'
                active: false
            }
            {
                title: '报名'
                icon: 's_signUp'
                iconTxt: '&#xe609;'
                url: '#/enroll'
                active: false
            }
            {
                title: '抽奖'
                icon: 's_draw'
                iconTxt: '&#xe6b8;'
                url: '#/lottery'
                active: false
            }
        ]

        for v in menu
            if v.url == hash
                v.active = true
                break

        @render require('../tpl/tag/footBtn.html'),
            menu: menu

Template.components['foot-btn'] = FootBtn
