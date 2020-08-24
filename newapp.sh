#!/bin/bash
mypath="$HOME/Appdev_web/meteor-svelte/"
cd $mypath
meteor create $1
cd $1
meteor npm i -S svelte
meteor remove blaze-html-templates
meteor add markdown svelte:compiler svelte:blaze-integration rdb:svelte-meteor-data static-html
mkdir -p imports/ui
echo "<header>
    <h1>$1</h1>
    </header>
    " > imports/ui/App.svelte
echo "import { Meteor } from 'meteor/meteor' 
import App from '../imports/ui/App.svelte'
Meteor.startup(() => {
  new App({
      target: document.getElementById('app')
        })
})
" > client/main.js
echo "<head>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
    <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' integrity='sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z' crossorigin='anonymous'>
      <title>$1</title>
      </head>

      <body>
        <div id='app'></div>
	</body>
" > client/main.html

meteor
