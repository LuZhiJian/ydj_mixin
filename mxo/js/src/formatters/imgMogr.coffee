###*
 *
 * 7牛图片处理
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

'use strict'
{Template, Route} = require 'mcoreapp'

Template.formatters['imgMogr'] =  (url, width, height, blur, quality)->
    url += '?imageMogr2/auto-orient/format/jpg/interlace/1'

    devicePixelRatio = window.devicePixelRatio or 1

    width = document.body.clientWidth or 375 if width == 'auto'

    if width
        # 指定目标图片宽度后高度等比缩放
        if !height
            url += "/thumbnail/#{width * devicePixelRatio}x"
        else
            # 当原图尺寸大于给定的宽度或高度时，按照给定宽高值缩小
            url += "/thumbnail/#{width * devicePixelRatio}x#{height * devicePixelRatio}>"

    # 指定目标图片高度后宽度等比缩放
    else if height
        url += "/thumbnail/x#{height * devicePixelRatio}"

    if blur
        url += "/blur/#{blur}"

    if quality
        url += "/quality/#{quality}"

    url
