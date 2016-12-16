###*
 * 接口
 * api
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

{http} = require 'mcoreapp'
$ = require 'jquery'
config = require './config'
util = require './util'
weui = require 'mcore-weui'
cache = require '../lib/cache'

$loading = $ '#app-loading'

_the_type = util.getQueryString 'the_type'

_host  = config.api.host

# 请求开始事件
http.onBeforeSend = -> $loading.show()

# 请求完成事件
http.onComplete = -> $loading.hide()

# 网络问题的错误处理
http.regErrCallback 'network', (xhr, status, hideError)->
    msg = '网络好像有点问题，请重试'

    # 后端是否返回错误信息
    if xhr.responseText
        try
            res = $.parseJSON xhr.responseText
            msg = res.error if res.error
        catch error

    httpCode = xhr.statusCode().status

    if httpCode
        msg = msg + ' ( code: ' + httpCode + ' )'

    # 是否需要隐藏
    if !hideError
        weui.Dialog.alert msg
    else
        console.log msg


# 业务上的错误提示
http.regErrCallback 'error', (res, hideError)->
    msg = res.response or res.msg or '服务器在开小差，没有回复'

    # 是否需要隐藏
    if !hideError
        weui.Dialog.alert msg
    else
        console.log msg

# 返回数据的处理
http.responseFormat = (res)-> res.response

#  报名
exports.signup = (data)->
    http.post _host + 'm=mfvote&c=signup&a=save', data


# 首页活动数据统计
exports.setDetail = ->
    http.get _host + 'm=mfvote&c=setting&a=getActivityDetail&the_type=' + _the_type

# 获取活动配置
exports.getSummary = ->
    http.get _host + 'm=mfvote&c=rank&a=getSummary&the_type=' + _the_type

# 检测是否关注公众号
exports.checkBind = (data)->
    http.post _host + 'm=mfvote&c=signup&a=checkBind', data

# 选手主页
exports.getInfo = (data)->
    http.get _host + 'm=mfvote&c=signup&a=get', data

# 投票
exports.vote = (data)->
    http.post _host + 'm=mfvote&c=signup&a=vote', data

# 检测是否能显示抽奖按钮
exports.checkLotteryCount = (data)->
    http.get _host + 'm=mfvote&c=lottery&a=checkLotteryCount', data

# 排行榜数据
exports.getList = (data)->
    http.get _host + 'm=mfvote&c=signup&a=getList', data

# 取选手票数
exports.getInfoVote = (data)->
    http.get _host + 'm=mfvote&c=rank&a=get', data

# 取7牛上传token
exports.getQininToken = ->
    http.get _host + 'm=mfvote&c=upload&a=uploadImg',
        flag: 2

# 转盘抽奖
exports.startLottery =  (data) ->
    http.post _host + 'm=mfvote&c=lottery&a=doLottery', data

# 获取底部技术支持
exports.getSupportTech = ->
    http.get _host + 'm=mfvote&c=setting&a=getSupportTech'

# 取所奖品信息列表
exports.getAllPrizeList = ->
    http.get _host + 'm=mfvote&c=lottery&a=activityPrizes&the_type=' + _the_type


# 获取抽中的奖品列表
exports.getPrizeList = (data) ->
    http.get _host + 'm=mfvote&c=lottery&a=myLotteryPrize', data


# 保存中奖人的联系方式
exports.saveContact = (data)->
    http.post _host + 'm=mfvote&c=lottery&a=saveContact', data, true


# 获取中奖人的联系方式
exports.getContact = (data)->
    http.get _host + 'm=mfvote&c=lottery&a=getMyContact', data, true
