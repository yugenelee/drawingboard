# Angular Sprout
### A starter project for AngularJS using Brunch.io

[AngularJS](http://angularjs.org) + [Brunch](http://brunch.io)

## Features
- Restful client baked in at model layer
- Simplified Routing and resolve system!!
- User authentication and session!!
- Facebook connect
- Beautiful ajax loading widget
- File uploader widget (based on jquery-file-upload)
- Confirmable form field
- Tags Input (based on jquery tags input)
- Notification System(bootstrap alert)
- Mobile ready(angularJS 1.1.5 NgMobile)
- PLUS all brunch goodies(auto-reload, coffeescript compilation, etc)

## TODO
- simplified form directive with real-time validation and better presentation
- model association(has-many, many-to-many)
- build a directive for gridster, turn this into a CMS!

## SECONDARY TODO
- scaffolding
- better use of oauth.io?
- linkedin integration


## How to use

    git clone https://github.com/sagittaros/angular-sprout.git
    cd angular-sprout
    scripts/init.sh
    scripts/server.sh
    open http://localhost:3313

##Note
Bower is removed. Add everything in /vendor folder

## ulimit nofile issue


#### Ubuntu
- edit /etc/security/limit.conf
- set ulimit -nofile to 10000 by adding these 2 lines 
    
        *  soft	nofile	10000
        *  hard	nofile	10000

- reboot
- check by `ulimit -n`

#### Mac OSX
    sudo ulimit -n 10000
    ulimit -n 10000

##Versions
- AngularJS 1.1.5
- Brunch.IO 1.6.7
