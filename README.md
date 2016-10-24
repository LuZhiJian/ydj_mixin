# 微信平台


## 框架，mcore

## grunt

```bash
# 如果没有安装 grunt，请先安装
sudo npm install grunt-cli -g

# 安装依赖包
npm install

# 开发, 在根目录执行
grunt

# 发布
grunt prod

# 生成页面导航
grunt nav-html
```

## libsass
[node-sass(libsass)](https://github.com/sass/sassc/blob/master/docs/building/unix-instructions.md) 和 [bourbon](http://bourbon.io/docs/)

```bash
# 安装 libsass 
# 在本地新建文件夹放置 libsass 和 sassc
mkdir sass
cd sass

# clone libsass 和 sassc
git clone https://github.com/sass/libsass.git
git clone https://github.com/sass/sassc.git

# 设置环境变量
export SASS_LIBSASS_PATH=/Users/you/path/libsass

# 编译 sassc
cd sassc
make

# 将 sassc 放到环境目录
ln -s /sassc-path /usr/local/bin/sassc
```

## 发布到 sit
```bash
# 合并 master 的代码到 sit, 然后执行
rbuild watch --config rbuild.sit.js

# 可以打开服务器查看合并效果
rbuild watch --config rbuild.sit.js --server -p 8084
```
