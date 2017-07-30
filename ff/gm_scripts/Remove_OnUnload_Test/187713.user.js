// ==UserScript==
// @name        Remove OnUnload Test
// @namespace   remove_onunload_test
// @include     http://www.thetaoofbadass.com/*
// @version     0.02
// @grant		none
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

document.addEventListener('DOMContentLoaded',function(){
  setTimeout(function(){
    var w = window;
    w.onunload = null;
    w.onbeforeunload = null;
  //console.log(w);
  },1000);
});