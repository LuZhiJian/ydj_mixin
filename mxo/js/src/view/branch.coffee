# 选择分店
# @author ciwyaitd
# @date   16/3/22
# @description []
'use strict'

class Branch extends require('./base')
    run: ->
        @render require('../tpl/view/branch.html')



module.exports = Branch
module.exports.viewName = 'branch'
