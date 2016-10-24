'use strict';



module.exports = function(grunt) {
  grunt.registerMultiTask('nav-html', '', function() {
    
    var options = this.options({
        
    });
    
    var regExp = /<title>.*<\/title>/;
    var Link = "<!DOCTYPE HTML>"+
                    "<html lang='en-US'>"+
                        "<head>"+
                        "<meta charset='UTF-8'>"+
                        "<title>总导航</title>"+
                        "<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'/>"+
                        "<style>"+
                        ".item {display: table-row; overflow: hidden; padding: 10px 0; color: #117ed2; text-decoration: none; font-size: 14px; height: 35px; }"+
                        ".item:last-child {border-bottom: 1px solid #d0d0d0;}"+
                        ".left, .right {display: table-cell; width: 50%; box-sizing: border-box; padding: 0 10px; line-height: 20px; border: 1px solid #d0d0d0; border-width: 1px 1px 0 0; vertical-align: middle;}"+
                        ".left {text-align: right; }"+
                        ".right {text-align: left;}"+
                        "</style>"+
                        "</head>"+
                        "<body>"+
                        "<div style=' margin: 0 auto; margin-top:15%;text-align:center; max-width: 800px; width: 100%; display: table; border: 1px solid #d0d0d0; border-width: 0 0 1px 1px;'>";
                        
    
    this.files.forEach(function(f) {
        
          var src = f.src.filter(function(filepath) {
            
              // grunt.log.warn(filepath);
              if(filepath == options.htmlname){
                return;
              }
              var html = grunt.file.read(filepath).toString();
              var t = html.match(regExp);
              var href = filepath.replace(/.+?\//, '');
              if(t!=null){
                var title = t.toString().replace("<title>","").replace("</title>","");
                var cont = '<span class="left">'+ title +'</span>' + '<span class="right">'+ href +'</span>'

                Link = Link + "<a class='item' href="+href+" >"+cont+"</a>";
              
              }
              
          });
          Link = Link+"</div></body></html>";
          grunt.file.write(options.htmlname, Link);  
    });
    
    
  });

};
