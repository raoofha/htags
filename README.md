# htags

htags is a simple library for working with html intended to use with coffeescript in electron or browserify

examples:
```javascript
require("htags").importTags()
class MyUIComp
    render: ->
        div {class:"classname"}, "hello world"
```
```javascript
H = require("htags").tags
class MyUIComp
    render: ->
        H.div [
            H.p "hello"
            H.br
            H.div "world"
        ]
```
