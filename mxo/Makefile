dev:
	@sudo browser-sync start --server --files 'build/dev/*.js' --port 80 &
	@webpack -w

wx:
	@sudo http-server -p 80 &
	@webpack -w

sit:
	@webpack --config webpack.sit.config.js

install:
	@npm install browser-sync -g --registry=https://registry.npm.taobao.org
	@npm install --registry=https://registry.npm.taobao.org


.PHONY: dev
