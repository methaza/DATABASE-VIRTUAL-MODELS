// ==UserScript==
// @name		Kill Sure Want To Nav Away
// @description	Kill "Are you sure you want to navigate away from this page|site" popups
// @include		http://*
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

location.href = "javascript:(" + function() {
  window.onbeforeunload = null;
  window.onunload = null;
} + ")()";
