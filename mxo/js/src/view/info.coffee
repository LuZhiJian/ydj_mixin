###*
 *
 * 选手主页
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

PopQRCode = require '../ui/popQRCode'

class Info extends require('./base')

    run: (home)->
        @scope.home = home
        @render require('../tpl/view/info.html'),
            info: @getInfo()
            vote: @getRank()
            summary: @api.getSummary()
        .then =>
            # 定义分享
            if @app.wxShare
                @app.wxShare
                    title: "#{@scope.info.signup_id} 号选手， #{@scope.info.name} 正参与#{@scope.summary.title}大赛，赶紧给她投一票吧！"
                    desc: "每投一票，100%有奖哦~~"
                    link: window.location.href.split('#')[0] + '#/info/' + @scope.info.home
                    imgUrl: @scope.info.img


    # 获取个人信息
    getInfo: ->
        data = {
            home: @scope.home,
            the_type: @context.the_type
        }
        @api.getInfo(data).then (res)=>
            @scope.username = res.name
            res

    # 获取选手排名与票数
    getRank: ->
        data = {
            home: @scope.home,
            the_type: @context.the_type
        }
        @api.getInfoVote data

    # 投票
    vote: ->
        if !@context.open_id
            @checkBind()
        else
            data = {
                home: @scope.home,
                the_type: @context.the_type
                open_id: @context.open_id
            }
            @api.vote(data).then (res)=>
                @showVoteSuc @scope.username

        false

    showImgs: (event, el, imgUrl, imgs)->
        data = []
        imgs.forEach (v)->
            data.push v.img

        if @app.wx
            @app.wx.previewImage
                current: imgUrl
                urls: data
        false


module.exports = Info
module.exports.viewName = 'info'
