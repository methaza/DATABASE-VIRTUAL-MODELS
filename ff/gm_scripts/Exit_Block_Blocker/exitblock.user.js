// ==UserScript==
// @namespace	http://javascript.about.com
// @author		Stephen Chapman
// @name		Exit Block Blocker
// @description	Blocks onbeforeunload
// @include		*
// @exclude 	*://up09.com/*
// @exclude 	*://upload.so/*
// @exclude 	*://tusfiles.net/*
// @exclude 	*://openload.co/*
// @exclude 	*://pix.wf/*
// @exclude 	*://imzdrop.com/*
// @exclude 	*://imgmega.com/*
// @exclude 	*://goimge.com/*
// @exclude 	*://imageon.org/*
// @exclude 	*://imageontime.com/*
// @exclude 	*://uplimg.com/*
// @exclude 	*://megaimage.org/*
// @exclude 	*://extraimg.org/*
// @exclude 	*://photoshare.link/*
// @exclude 	*://imageteam.org/*
// @exclude 	*://imgdrive.co/*
// @exclude 	*://imgchili.net/*
// @exclude 	*://img.yt/*
// @exclude 	*://imgdevil.com/*
// @exclude 	*://*.up09.com/*
// @exclude 	*://*.upload.so/*
// @exclude 	*://*.tusfiles.net/*
// @exclude 	*://*.openload.co/*
// @exclude 	*://*.pix.wf/*
// @exclude 	*://*.imzdrop.com/*
// @exclude 	*://*.imgmega.com/*
// @exclude 	*://*.goimge.com/*
// @exclude 	*://*.imageon.org/*
// @exclude 	*://*.imageontime.com/*
// @exclude 	*://*.uplimg.com/*
// @exclude 	*://*.megaimage.org/*
// @exclude 	*://*.extraimg.org/*
// @exclude 	*://*.photoshare.link/*
// @exclude 	*://*.imageteam.org/*
// @exclude 	*://*.imgdrive.co/*
// @exclude 	*://*.imgchili.net/*
// @exclude 	*://*.img.yt/*
// @exclude 	*://*.imgdevil.com/*
// ==/UserScript==

var th = document.getElementsByTagName('body')[0];
var s = document.createElement('script');
s.setAttribute('type','text/javascript');
s.innerHTML = "window.onbeforeunload = function() {}";
th.appendChild(s);
