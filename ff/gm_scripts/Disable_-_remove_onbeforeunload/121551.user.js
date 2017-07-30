// ==UserScript==
// @name		Disable - remove onbeforeunload
// @namespace	
// @description	Disable - remove the annoying onbeforeunload event
// @include		*
// @author		netvisiteurs.com
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

var x = document.createElement('script');
x.type = 'text/javascript';
x.innerHTML = 'onbeforeunload = function() {};';
document.body.appendChild(x);