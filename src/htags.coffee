tagnames = ['html', 'head', 'title', 'base', 'link', 'meta', 'style', 'script',
  'noscript', 'body', 'body', 'section', 'nav', 'article', 'aside', 'h1', 'h2',
  'h3', 'h4', 'h5', 'h6', 'h1', 'h6', 'header', 'footer', 'address', 'main',
  'main', 'p', 'pre', 'blockquote', 'ol', 'ul', 'li', 'dl', 'dt', 'dd',
  'dd', 'figure', 'figcaption', 'div', 'a', 'em', 'strong', 'small', 's',
  'cite', 'q', 'dfn', 'abbr', 'data', 'time', 'code', 'var', 'samp', 'kbd',
  'sub', 'sup', 'i', 'b', 'u', 'mark', 'ruby', 'rt', 'rp', 'bdi', 'bdo',
  'span', 'wbr', 'ins', 'del', 'img', 'iframe', 'embed', 'object',
  'param', 'object', 'video', 'audio', 'source', 'video', 'audio', 'track',
  'video', 'audio', 'canvas', 'map', 'area', 'area', 'map', 'svg', 'math',
  'table', 'caption', 'colgroup', 'col', 'tbody', 'thead', 'tfoot', 'tr', 'td',
  'th', 'form', 'fieldset', 'legend', 'fieldset', 'label', 'input', 'button',
  'select', 'datalist', 'optgroup', 'option', 'select', 'datalist', 'textarea',
  'keygen', 'output', 'progress', 'meter', 'details', 'summary', 'details',
  'menuitem', 'menu']

    
appendChild = (elem, childs)->
    if typeof childs is "string" or typeof childs is "number"
        #elem.innerText += childs
        elem.textContent += childs
    if childs instanceof HTMLElement
        elem.appendChild(childs)
    if childs and childs.render
        appendChild(elem,childs.render())
    else if Array.isArray childs
        for c in childs
            appendChild(elem, c)

argsparser = (arg1, arg2)->
    [attrs, contents] =
        if not arg1? and not arg2?
            [{}, []]
        else if Array.isArray arg1
            [{}, arg1]
        else if typeof arg1 is "string" or arg1 instanceof HTMLElement or typeof arg1 is "number" or (arg1 and arg1.render)
            [{}, [arg1]]
        else if typeof arg2 is "string" or arg2 instanceof HTMLElement or typeof arg2 is "number" or (arg2 and arg2.render)
            [arg1, [arg2]]
        else
            [arg1, arg2]

mktag = (tagname)-> (arg1, arg2)->
    [attrs, contents] = argsparser(arg1,arg2)
    t = document.createElement(tagname)
    if attrs
        for at, v of attrs
            if at is "class"
                t.className = v
            if at.substring(2) is "on"
                t.addEventListener at, v
            else if at.startsWith("data")
                t.dataset[at.substring(5)] = v
            else
                t[at] = v
    appendChild(t, contents)
    t
tags = {}
for name in tagnames
    tags[name] = mktag(name)
#tags.br = document.createElement("br")
#tags.hr = document.createElement("hr")
Object.defineProperty tags, "br", get: -> document.createElement("br")
Object.defineProperty tags, "hr", get: -> document.createElement("hr")

module.exports = {
    tags
    argsparser
    import: ->
        for name, tag of tags
            window[name] = tag
        Object.defineProperty window, "br", get: -> document.createElement("br")
        Object.defineProperty window, "hr", get: -> document.createElement("hr")
}


