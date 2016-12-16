var config = require('./webpack.config').buildEnv('sit', '//wxalicdn.meimeifa.com/hsl/sp/mxo');
//var path = require('path');
var del = require('del');

del.sync(['./build/sit/**/*.*']);


module.exports = config;
