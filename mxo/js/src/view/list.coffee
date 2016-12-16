###*
 * 排行
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

PopQRCode = require '../ui/popQRCode'
{util} = require 'mcoreapp'

class List extends require('./base')

    run: ->

        @context.type or = 1
        @context.name or = ''

        @scope.type = @context.type #1:默认2:最新3:排名
        @scope.name = @context.name #搜索
        @scrollTime = null

        @isInLoad = false
        @isLastData = false
        @isLeft = true

        @render require('../tpl/view/list.html'),
            list:
                left: []
                right: []

        .then =>
            @set 'list', @getData()
            $list = @$el.find('.s_list')
            @.$list = $list

            $list.off('scroll').on 'scroll', =>
                clearTimeout @scrollTime if @scrollTime

                @scrollTime = setTimeout =>
                    height = $list.height()
                    scrollTop = $list.scrollTop()
                    #console.log scrollTop,  $list[0].offsetHeight - 50
                    if scrollTop > $list[0].offsetHeight - 50
                        @scope.showGoTop = true
                        return if @isLastData or @isInLoad
                        @getData @page + 1
                    else if scrollTop > $list[0].clientHeight
                        @scope.showGoTop = true
                    else
                        @scope.showGoTop = false
                , 300


    goTop: ->
        if @.$list
            @.$list.scrollTop 0
        false

    # 投票
    vote: (event, el, home, username)->
        if !@context.open_id
            @checkBind()
        else
            data = {
                home: home,
                the_type: @context.the_type
                open_id: @context.open_id
            }
            @api.vote(data).then (res)=>
                @showVoteSuc username

        false

    # 更改搜索名
    changeName: (event, el)->
        @scope.name = String(el.value).trim()
        false


    # 选手主页
    goInfo: (event, el, home)->
        if @context.open_id
            window.location.href = "#/info/#{home}?open_id=#{@context.open_id}&the_type=#{@context.the_type}"
            false
        else
            window.location.href = "#/info/#{home}?the_type=#{@context.the_type}"
            false

    # 搜索
    find: (event, el)->
        url = "#/list?name=#{encodeURIComponent @scope.name}&type=#{@scope.type}&the_type=#{@context.the_type}"
        if @context.open_id
            url += "&open_id=#{@context.open_id}&the_type=#{@context.the_type}"
        window.location.href = url
        false

    getData: (page = 0)->
        @page = page
        @isInLoad = true
        @api.getList
            the_type: @context.the_type
            type: @scope.type
            name: @scope.name
            p: page
        .then (res = [])=>
            # 没有数据
            # if res.length == 0 or !res[0]['home']
            if res.length == 0
                @isLastData = true
                data =
                    left: []
                    right: []

                return data

            if page == 0
                data =
                    left: []
                    right: []
                @isLeft = true
            else
                data = @scope.list

            for v in res
                if @isLeft
                    @isLeft = false
                    data.left.push v
                else
                    @isLeft = true
                    data.right.push v

            #console.log data
            data
        .always =>
            @isInLoad = false

module.exports = List
module.exports.viewName = 'list'
