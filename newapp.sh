#!/bin/bash
mypath="$HOME/Appdev_web/meteor-svelte/"
cd $mypath
meteor create $1
cd $1
# installing framework
echo "Project name: $1"
echo "installing framework in $1"
meteor npm i -S svelte
meteor remove blaze-html-templates
meteor add markdown svelte:compiler svelte:blaze-integration rdb:svelte-meteor-data static-html
mkdir -p imports/ui

# creating svelte template
sleep 1
echo creating svelte template
echo "<header>
    <h1>$1</h1>
    </header>
    " > imports/ui/App.svelte
# setting fw up
sleep 1
echo setting fw up
echo "import { Meteor } from 'meteor/meteor' 
import App from '../imports/ui/App.svelte'
Meteor.startup(() => {
  new App({
      target: document.getElementById('app')
        })
})
" > client/main.js

# creating main html page
sleep 1
echo creating main html page
echo "<head>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
    <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' integrity='sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z' crossorigin='anonymous'>
      <title>$1</title>
      </head>

      <body>
        <div id='app'></div>
	</body>
" > client/main.html

sleep 1
echo open and launch
code ./

meteor
