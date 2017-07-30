// ==UserScript==
// @name			Linkify Plus Redirect
// @version			2.1.4
// @namespace		http://arantius.com/misc/greasemonkey/
// @description		Turn plain text URLs into links.	Supports http, https, ftp, email addresses.
// @author			DarKWinGTM
// @include			http://is.gd/*
// @include			https://is.gd/*
// @include			http://bit.ly/*
// @include			https://bit.ly/*
// @include			http://bitly.com/*
// @include			https://bitly.com/*
// @include			http://api.bit.ly/*
// @include			https://api.bit.ly/*
// @include			http://api.bitly.com/*
// @include			https://api.bitly.com/*
// @namespace		
// @downloadURL		
// @updateURL		
// ==/UserScript==

var dllink = null;
var domain = (window.location != window.parent.location) ? document.referrer.toString() : document.location.toString();
var domain = domain.replace("http://","").replace("https://","").replace("http://www.","").replace("https://www.","").replace("www.","").split("/")[0];
// var domain = domain.substr(0, domain.lastIndexOf("."))
var listho = 'bit.ly|api.bit.ly|is.gd';

if(domain.match(listho)) {
	console.log('[RC] LOCAL : ' + (domain) + ' 0');
	var linkifyplusredirect = setInterval(function() {
		if(document.querySelectorAll('.linkifyplus') != null) {
			//	console.log('[RC] LOCAL : ' + (domain) + ' 1');
			document.querySelectorAll('.linkifyplus')[1].click();
			//	console.log('[RC] LOCAL : ' + (domain) + ' 2');
			//	clearInterval(linkifyplusredirect);
		}
	}, 3000);
}