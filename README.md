# Hello friends :grinning:
## This is a script for an easy meteor setup including svelte.

Its filename is **newapp.sh**.  
Before, there are a few things to handle:

- it was written for ***linux/BSD/MAC*** (! a mere bash file :wink:)  
  > what if i use Windows ?  
    > well, you may install bash, an .exe will be added very soon.
- the default path is your home one followed by **Appdev_web/meteor-svelte** (ie **/home/[your_name]/Appdev_web/meteor-svelte**). You may easily change this inside the path name (named *$mypath*);
- bootstrap is the default css framework, once more you comment or delete it two ways:
    - inside file (if you wanna change automation),
    - or inside **client/main.html** file.
- backend collection is customizable, its default name is **Thingies**,; you may replace names and fields.

## Setup steps

Here are the steps to install it:

  1. open a terminal and 'cd' to you meteor folder.
  2. clone or download the repo content into your chosen folder.
  3. enter ```./newapp.sh``` followed by your project name.  



## Customize

Of course you may modify it for your own usage.  



One more thing: default editor is **Visual Studio Code**. If you use another one, just replace **code** whith your own editor name in *newapp.sh* (for example ```atom``` for *atom* - ```subl``` if it is *sublime-text*).
That's all. Enjoy!

*PS: Obviously, if you have any questions, simply contact me to <fabezio@outlook.fr>*