// ==UserScript==
// @name         skip bitly.com warnning
// @namespace    http://warnning.bitly.com.cologler/
// @version      1.0
// @description  skip bitly.com warnning
// @author       Cologler
// @match        *://bitly.com/a/warning?url=*&hash=*
// @match        *://bitly.com/a/warning?url=*
// @match        *://bitly.com/a/*
// @grant        none
// ==/UserScript==

function GetParametersDictionary(url) {
    var dict = new Object();
    var pstart = url.indexOf("?");
    if (pstart > -1 && url.length > pstart + 1) {
        var pstr = url.substr(pstart + 1);
        strs = pstr.split("&");
        for(var i = 0; i < strs.length; i ++) {
            var key = strs[i].split("=")[0];
            var value = unescape(strs[i].split("=")[1]);
            dict[key] = value;
        }
    }
    return dict;
}

var url = location.href;
var para = GetParametersDictionary(url);
location.href = para['url'];