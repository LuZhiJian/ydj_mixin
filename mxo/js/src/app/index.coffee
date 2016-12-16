###*
# sh
# @date 2016-01-29 15:38:50
# @author vfasky <vfasky@gmail.com>
# @link http://vfasky.com
###
'use strict'

mcoreapp = require 'mcoreapp'
require 'mcore-weui'
$ = require 'jquery'

require '../../../style/sass/app.scss'

require('mcoreExtPlusWatch') mcoreapp

# load binder
require('../binder/qiniuUploader') mcoreapp

# load formatters
require '../formatters/urlJoin'
require '../formatters/imgMogr'
require '../formatters/imgSize'

# load tag
require '../tag/footBtn'
require '../tag/topTitle'
# require '../tag/userList'


app = new mcoreapp.App $('body')

app.$loading = $('#app-loading').hide()

app.use require '../middleware/wx'

app.route '/', require('../view/index')
   .route '/rule', require('../view/rule')
   .route '/list', require('../view/list')
   .route '/lottery', require('../view/lottery')
   .route '/info/:home', require('../view/info')
   .route '/prize', require('../view/prize')
   .route '/branch', require('../view/branch')
   .route '/enroll', require('../view/enroll')
   .route '/getPrize', require('../view/getPrize')
   .route '*', require('../view/index')



app.run()
