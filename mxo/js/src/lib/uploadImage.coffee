###*
 *
 * 上传图片
###

'use strict'
$ = require 'jquery'

module.exports = (data, options = {})->
    $.ajax
        xhr: ->
            xhr = new window.XMLHttpRequest

            xhr.upload.addEventListener 'progress', (evt) =>
                if evt.lengthComputable
                    upProgress = evt.loaded / evt.total
                    upPercent = Math.round(upProgress * 100) + '%' if upProgress

                    if !isNaN(upProgress) and options.fileProgress
                        options.onProgress upPercent
            , false

            xhr

        url: options.uploadUrl or 'http://up.qiniu.com'
        type: 'POST'
        data: data
        processData: false
        contentType: false
        xhrFields:
            withCredentials: false
    .then (res) =>
        options.imgDomain or= 'http://7xiau2.com2.z0.glb.qiniucdn.com/'
        options.imgDomain + res.key
