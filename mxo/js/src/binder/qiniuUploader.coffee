###*
 *
 * 7牛上传
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

$ = require 'jquery'
uploadImage = require '../lib/uploadImage'
weui = require 'mcore-weui'
api = require '../app/api'

# 是否图片
isImg = (file)->
    return false if !file.type

    type = String(file.type).toLowerCase()

    return false if type.indexOf('image/') != 0

    imgType = type.replace 'image/', ''
    return imgType in ['jpg', 'jpeg', 'png', 'gif', 'bmp']

module.exports = (mcore)->
    {Template, util} = mcore

    Template.binders['qiniu-uploader'] =

        rendered:(el, value)->
            $el = $ el
            callback = Template.strToFun(el, value) or ->

            $el.on 'change', ->
                $el.hide()
                return false if !el.files or el.files.length == 0

                # 只取一个
                file = el.files[0]
                if false == isImg file
                    weui.Dialog.alert '抱歉，只支持上传 jpg, png, gif, bmp 格式图片'
                    return false

                weui.Toast.loading.show()

                api.getQininToken().then (token)->

                    formData = new FormData()
                    formData.append 'file', file
                    formData.append 'token', token

                    uploadImage formData

                .then (res)->
                    callback res

                .always ->
                    $el.show().val ''
                    weui.Toast.loading.hide()
