# ReactInit
A batch script for initializing React projects on Windows

Syntax:  
_ReactInit.bat [folder name]_  
Where _[folder name]_ is an optional parameter which can specify a directory where the React project will be initialized

This script requires NPM which can be installed as part of the [NodeJS package](https://nodejs.org/en/)  
Make sure you add the NodeJS directory to your computer's path variable


This batch script will do the following:  
 1. Initialize NPM
 2. Download React
 3. Download Babel and Babel presets for React and ES6
 4. Download Webpack
 5. Create the .babelrc configuration file  
  * Allows Babel to transform JSX to JS and ES6 to ES5
 6. Create the webpack.config.js
  * Creates the html-webpack-plugin config object for copying the index.html file into a "build" directory  
  This also injects the script tag which links to index.js
  * Instructs Babel to transform the index.js root file from JSX to JS and ES6 to ES5, and place a bundled output in the "build" directory
 7. Modifies package.json to create the following two NPM scripts:
  1. npm run build: Will build the React app
  2. npm run start: Will start the webpack-dev-server
 8. Creates the directories ./app/components
 9. In _./app_ creates the following:
  1. An index.html file with a basic template
  2. An index.js file that renders the main App component
 10. In _./app/components_ creates the following:
  1. An App.js component which renders a "Hello World" h1
 11. Calls _npm run build_
 

Following this, the user can call **_npm run start_** from the command line to run the Webpack server, which will allow for viewing the React app at [http://localhost:8080](http://localhost:8080)
    
