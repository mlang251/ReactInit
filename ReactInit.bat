cls

cd ../
md %1
cd %1

call npm init -y
call npm i -S react react-dom
call npm i -D babel-core babel-loader babel-preset-react
call npm i -D webpack webpack-dev-server html-webpack-plugin

echo {presets: ['react']} > .babelrc

echo var HTMLWebpackPlugin = require('html-webpack-plugin'); > webpack.config.js
echo var HTMLWebpackPluginConfig = new HTMLWebpackPlugin({ >> webpack.config.js
echo 	template: __dirname + '/app/index.html', >> webpack.config.js
echo 	filename: 'index.html', >> webpack.config.js
echo 	inject: 'body' >> webpack.config.js
echo }); >> webpack.config.js
echo: >> webpack.config.js
echo module.exports = { >> webpack.config.js
echo 	entry: __dirname + '/app/index.js', >> webpack.config.js
echo 	module: { >> webpack.config.js
echo 		loaders: [ >> webpack.config.js
echo 			{ >> webpack.config.js
echo 				test: /\.js$/, >> webpack.config.js
echo 				exclude: /node_modules/, >> webpack.config.js
echo 				loader: 'babel-loader' >> webpack.config.js
echo 			} >> webpack.config.js
echo 		] >> webpack.config.js
echo 	}, >> webpack.config.js
echo 	output: { >> webpack.config.js
echo 		filename: 'transformed.js', >> webpack.config.js
echo 		path: __dirname + '/build' >> webpack.config.js
echo 	}, >> webpack.config.js
echo 	plugins: [HTMLWebpackPluginConfig] >> webpack.config.js
echo }; >> webpack.config.js

echo { > package.json
echo   "name": "reacttest", >> package.json
echo   "version": "1.0.0", >> package.json
echo   "description": "", >> package.json
echo   "main": "index.js", >> package.json
echo   "scripts": { >> package.json
echo     "build": "webpack", >> package.json
echo     "start": "webpack-dev-server" >> package.json
echo   }, >> package.json
echo   "author": "", >> package.json
echo   "license": "ISC", >> package.json
echo   "dependencies": { >> package.json
echo     "react": "^15.4.0", >> package.json
echo     "react-dom": "^15.4.0" >> package.json
echo   }, >> package.json
echo   "devDependencies": { >> package.json
echo     "babel-core": "^6.18.2", >> package.json
echo     "babel-loader": "^6.2.7", >> package.json
echo     "babel-preset-react": "^6.16.0", >> package.json
echo     "html-webpack-plugin": "^2.24.1", >> package.json
echo     "webpack": "^1.13.3", >> package.json
echo     "webpack-dev-server": "^1.16.2" >> package.json
echo   } >> package.json
echo } >> package.json

md app\components
cd app

echo ^<!DOCTYPE html^> > index.html
echo ^<html^> >> index.html
echo 	^<head^> >> index.html
echo 		^<meta charset = "utf-8"^> >> index.html
echo 		^<title^>My First Local App^</title^> >> index.html
echo 	^</head^>                     >> index.html
echo 	^<body^>                      >> index.html
echo 		^<div id = "app"^>^</div^>  >> index.html
echo 	^</body^>                     >> index.html
echo ^</html^> >> index.html

echo var React = require('react'); > index.js
echo var ReactDOM = require('react-dom'); >> index.js
echo var App = require('./components/App'); >> index.js
echo: >> index.js
echo ReactDOM.render(^<App /^>, document.getElementById('app')); >> index.js

cd components

echo var React = require('react'); > App.js
echo: >> App.js
echo var App = React.createClass({ >> App.js
echo 	render: function() { >> App.js
echo 		return ^<h1^>Hello World^</h1^>; >> App.js
echo 	} >> App.js
echo }); >> App.js
echo: >> App.js
echo module.exports = App; >> App.js

call npm run build



