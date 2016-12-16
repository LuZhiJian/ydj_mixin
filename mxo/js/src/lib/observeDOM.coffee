###*
 *
 * 观察dom的变化
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

MutationObserver = window.MutationObserver or window.WebKitMutationObserver
eventListenerSupported = window.addEventListener

module.exports = (dom, callback = ->) ->
    if MutationObserver
        obs = new MutationObserver (mutations, observer)->
            # 添加或删除，通知
            if mutations[0].addedNodes.length or mutations[0].removedNodes.length
                callback dom
                return
        if obs.observe
            try
                obs.observe dom,
                    childList: true
                    subtree: true
            catch error
                console.log err


    else if eventListenerSupported
        dom.eventListenerSupported 'DOMNodeInserted', ->
            callback dom
        , false
        dom.eventListenerSupported 'DOMNodeRemoved', ->
            callback dom
        , false
        return
