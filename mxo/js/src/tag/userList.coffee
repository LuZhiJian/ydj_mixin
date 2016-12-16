###*
 *
 * 用户列表
 * @author vfasky <vfasky@gmail.com>
###
'use strict'
{Component, Template, util} = require 'mcoreapp'
#IScroll = require 'iscroll/build/iscroll-lite'
IScroll = require 'iscroll/build/iscroll'
$ = require 'jquery'


class UserList extends Component

    init: ->

        @render require('../tpl/tag/userList.html'),
            list:
                left: []
                right: []




    watch: ->
        @on 'rendered', =>
            @.$el = $ @refs
            if @.$el.find('.img-shot').length
                return @scroll.refresh() if @scroll

                @scroll = new IScroll @refs,
                    mouseWheel: true
                    # scrollbars: true

                setTimeout =>
                    @scroll.refresh()
                    console.log @scroll
                , 1000







Template.components['user-list'] = UserList
