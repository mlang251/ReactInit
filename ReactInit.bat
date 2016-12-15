echo off
cls


:: Enable command extensions so that the "if not defined" syntax becomes valid
::
setlocal enableextensions


:: Store the first parameter in a variable, if a parameter was not defined, set the variable equal to "newApp"
::
set folderName=%1
if not defined folderName set foldername=newApp


:: If the folder doesn't exist, make it
::
if not exist %folderName% (
	md %folderName%
)

cd %folderName%


:: Initialize NPM and use it download React, Babel, and Webpack
::
call npm init -y
call npm i -S react react-dom
call npm i -D babel-core babel-loader babel-preset-react babel-preset-es2015
call npm i -S babel-polyfill
call npm i -D webpack webpack-dev-server html-webpack-plugin


:: Create the .babelrc configuration file
:: This allows Babel to transform JSX into normal JS and ES6 into ES5
::
echo {presets: ['react', 'es2015']} > .babelrc




:: Create the webpack.config.js file
:: This specifies which files to transform, how to transform them, and where to put the transformed files
:: The transformed files will be index.html and transformed.js, these will both be in the newly created "build" folder
:: Webpack will inject a script tag linking to transformed.js in the body of index.html
::
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




:: Modify the package.json file
:: This function will iterate through all the lines in package.json and insert custom scripts to be run from NPM
:: 		Does this by copying line by line from package.json into temp.txt
:: The for loop is searching for the string "  "scripts"", full colons are the delimeters
:: 		When it finds the string, two custom scripts will be inserted into temp.txt
:: Afterwards, the for loop continues copying lines from package.json to temp.txt
:: Finally, package.json is overwritten with the contents of temp.txt and temp.txt is deleted
::
:: The custom scripts are:
::		npm run build - This will transform the React app into production-ready minified JS and output the transformed files in the "build" folder
::		npm run start - This will run the Webpack server with hot-loading, so that the user can view the React app at http://localhost:8080
::
for /f "tokens=1,* delims=:" %%G in (package.json) do (
	if "%%H"=="" (
		:: This check is necessary because if there is no semicolon in the line, we only want to echo the first token
		echo %%G >> temp.txt
	) else (
		:: Otherwise, we can echo the first token, then a semicolon, then the second token, which is the rest of the line
		echo %%G:%%H >> temp.txt
	)
	
	if "%%G"=="  "scripts"" (
		echo     "build": "webpack -p", >> temp.txt
		echo     "start": "webpack-dev-server --inline", >> temp.txt
	)
)


:: Overwrite package.json with the contents of temp.txt, then delete temp.txt
::
type temp.txt > package.json
del /q temp.txt

md app\components
cd app


:: Create a basic index.html file
::
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


::Create a basic index.js file to render the React App component
::
echo var React = require('react'); > index.js
echo var ReactDOM = require('react-dom'); >> index.js
echo var App = require('./components/App'); >> index.js
echo: >> index.js
echo ReactDOM.render(^<App /^>, document.getElementById('app')); >> index.js

cd components


:: Create a basic App.js React component to render a "Hello World" h1
::
echo var React = require('react'); > App.js
echo: >> App.js
echo var App = React.createClass({ >> App.js
echo 	render: function() { >> App.js
echo 		return ^<h1^>Hello World^</h1^>; >> App.js
echo 	} >> App.js
echo }); >> App.js
echo: >> App.js
echo module.exports = App; >> App.js


:: Transform the React files into regular JS
::
call npm run build


echo:
echo:
echo:
echo:
echo React app successfully built
echo Navigate to the folder and call npm run start to run the Webpack server
echo The app can be viewed at http://localhost:8080
echo:
echo:





