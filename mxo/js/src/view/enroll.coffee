# 我要报名
# @author
# @date   16/3/22
# @description []
'use strict'

weui = require 'mcore-weui'
util = require '../app/util'
PopQRCode = require '../ui/popQRCode'

class Enroll extends require('./base')
    run: ->
        @maxImg = 10
        @render require('../tpl/view/enroll.html'),
            showUploader: true
            tech: @getSupportTech()
            imgs: []
            openId: @context.open_id or null
            isHide: @context.id or false
        .then =>
            @checkBind()

    signup: (err, data)->
        if !@context.open_id
            @checkBind()
        else
            return @showValidatorErr err if err
            if @scope.imgs.length == 0
                weui.Dialog.alert '传张图片吧 ^_^'
                return false

            data.the_type = @context.the_type
            data.open_id = @context.open_id
            data.images = @scope.imgs

            @api.signup(data).then (res)->
                window.location.href = "#/info/#{res}?open_id=#{data.open_id}&the_type=#{data.the_type}"


        false

    # 图片上传完成
    fileUploaded: (img)->
        @scope.imgs.push img
        if @scope.imgs.length >= @maxImg
            @scope.showUploader = false

    # 移除图片
    removeImg: (event, el, ix)->
        @scope.imgs.splice ix, 1
        if @scope.imgs.length < @maxImg
            @scope.showUploader = true
        false



module.exports = Enroll
module.exports.viewName = 'enroll'
