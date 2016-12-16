###*
 *
 * 基于本地存储的缓存
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

_localStorage = window.localStorage

_cachePre = '__cache_'

maxTime = 3600 * 24 * 365 * 1000

module.exports =
    set: (key, value, time = maxTime)->
        time = (new Date()).getTime() + parseInt(time)
        data =
            time: time
            value: value

        _localStorage.setItem _cachePre + key, JSON.stringify data

    get: (key, defaultVal = null)->
        data = _localStorage.getItem _cachePre + key
        return defaultVal if !data

        try
            data = JSON.parse data
        catch error
            return defaultVal

        curTime = (new Date()).getTime()

        return data.value if curTime <= data.time

        module.exports.remove key

        defaultVal

    remove: (key)->
        _localStorage.removeItem _cachePre + key


    promise: (key, promise, time)->
        data = module.exports.get key
        if data
            dtd = $.Deferred()
            dtd.resolve data
            return dtd.promise()

        promise().then (res)->
            module.exports.set key, res, time
            res
