###*
 *
 * 投票成功弹窗
 * @author luzhijian <luzhijian24@gmail.com>
###
'use strict'

{Component} = require 'mcoreapp'

class PopVoteSuc extends Component
    hide: ->
        @scope.isShow = false

    show: (name)->
        @scope.name = name

        @scope.isShow = true
        @render require('../tpl/ui/voteSuc.html')

module.exports = PopVoteSuc
