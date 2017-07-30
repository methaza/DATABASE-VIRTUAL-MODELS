// ==UserScript==
// @name          Simple html numeric captcha solver
// @description   After you click "Slow download" button the script solves the numeric captcha, waits for the countdown to finish, clicks the download button
// @include       *://www.rziz.net/*/*.html
// @include       *://file.up09.com/*
// @include       *://clicknupload.com/*
// @include       *://hulkload.com/*
// @include       *://up4.im/*
// @include       *://mrfile.co/*.html
// @include       *://fileshd.net/*
// @include       *://nizfile.net/*.html
// @include       *://lynxshare.com/*
// @include       *://upvast.com/*
// @include       *://up07.net/*
// @include       *://up08.net/*
// @include       *://media4up.com/*
// @include       *://*.media4up.com/*
// @include       *://datasbit.com/*
// @include       *://uploadserv.com/*
// @include       *://*.uploadserv.com/*
// @include       *://faststore.org/*
// @include       *://oload.net/*
// @include       *://katfile.com/*
// @include       *://file-upload.cc/*
// @include       *://xeupload.com/*
// @include       *://www.up-4ever.com/*
// @include       *://drfile.net/*
// @include       *://zapfile.net/*
// @include       *://jolinfile.com/*
// @include       *://arabloads.net/*
// @include       *://*.arabloads.net/*
// @include       *://btafile.com/*
// @include       *://*.btafile.com/*
// @include       *://4downfiles.org/*
// @include       *://*.4downfiles.org/*
// @include       *://megafiles.us/*
// @include       *://*.megafiles.us/*
// @include       *://filedot.xyz/*
// @include       *://*.filedot.xyz/*
// @version       1.0.8
// @author        wOxxOm
// @namespace     wOxxOm.scripts
// @license       MIT License
// @grant         none
// @run-at        document-end
// ==/UserScript==


var x = document.evaluate('//form//div/span[contains("0123456789",.) and contains(@style,"padding-left")]', document,
						  null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
var btn = document.querySelector('[id*="btn"][id*="download"]');
if (x && btn) {
	var nodes = [];
	for (i = 0; i < 4; i++)
		nodes.push(x.snapshotItem(i));
	var nodes = nodes.sort(function(a,b){ return parseInt(a.style.paddingLeft) - parseInt(b.style.paddingLeft) });
	document.forms.F1.code.value = nodes.map(function(n){ return n.textContent }).join('');

	if (location.href.indexOf('clicknupload.com|file.up09.com') >= 0)
		document.forms.F1.submit();
	else if (location.href.indexOf('megafiles.us') >= 0)
		if (document.getElementsByClassName('err')[0].className != null)
			new MutationObserver(function(mutations) {
				if (!btn.disabled)
					document.forms.F1.submit();
			}).observe(btn, {attributes:true, attributesFilter:['disabled']});
		else if (document.getElementsByClassName('err')[0].className == null)
			document.forms.F2.submit();	
	else
		new MutationObserver(function(mutations) {
			if (!btn.disabled)
				document.forms.F1.submit();
		}).observe(btn, {attributes:true, attributesFilter:['disabled']});
}

if (location.href.indexOf('jolinfile.com') >= 0 && document.getElementsByName('method_free')[0].getAttribute('type') == "submit"){
	document.getElementsByName('method_free')[0].click();
}

if (location.href.indexOf('filedot.xyz') >= 0){
	if (document.getElementsByClassName('err')[0].className != null){		
		new MutationObserver(function(mutations) {
			if (!btn.disabled)
				document.forms.F1.submit();
		}).observe(btn, {attributes:true, attributesFilter:['disabled']});
	}else if (document.getElementsByClassName('err')[0].className == null){
		document.forms.F2.submit();	
	}
}
if (location.href.indexOf('media4up.com') >= 0){
	if (document.getElementsByClassName('err')[0].className != null){		
		new MutationObserver(function(mutations) {
			if (!btn.disabled)
				document.forms.F1.submit();
		}).observe(btn, {attributes:true, attributesFilter:['disabled']});
	}else if (document.getElementsByClassName('err')[0].className == null){
		document.forms.F2.submit();	
	}
}