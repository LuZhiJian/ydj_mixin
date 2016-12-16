###*
 *
 * touch slider
 * @author vfasky <vfasky@gmail.com>
###
'use strict'

module.exports = (mcore)->
    {Template, util} = mcore

    Swiper = require 'swiper'
    $ = require 'jquery'
    observeDOM = require '../lib/observeDOM'

    require 'swiper/dist/css/swiper.css'

    Template.binders['swiper'] =

        rendered:(el, events)->
            $el = $ el
            options =
                scrollbar: $el.find('.swiper-scrollbar')[0]
                direction: 'vertical'
                slidesPerView: 'auto'
                mousewheelControl: true
                freeMode: true
                #lazyLoading: true


            swiper = new Swiper el, options

            if util.isPlainObject events
                for key, fun of events
                    swiper.on key, Template.strToFun el, fun

            setTimeout ->
                console.log $el
            , 1000
            observeDOM el, ->
                console.log 'up?'
