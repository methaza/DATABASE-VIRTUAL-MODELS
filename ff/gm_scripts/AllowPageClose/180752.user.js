// ==UserScript==
// @name        AllowPageClose
// @namespace   http://userscripts.org/users/132107
// @description because I'd rather hit ctrl+shift+t and re-enter shit
// @version     1
// @grant       none
// @exclude 	*://up09.com/*
// @exclude 	*://upload.so/*
// @exclude 	*://tusfiles.net/*
// @exclude 	*://openload.co/*
// @exclude 	*://oload.net/*
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
// @exclude 	*://*.oload.net/*
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

var closeDisableIterations = 0;
var tamperingDetected = false;
function disableCloseInterception()
{
    if(unsafeWindow.onbeforeunload != null)
        tamperingDetected = true;
    unsafeWindow.onbeforeunload=null; //because FUCK YOU i want to close the fucking window
    if(tamperingDetected)
    {
        setTimeout(disableCloseInterception, 1000);
        return;
    }
    if(closeDisableIterations < 10)
    {
        closeDisableIterations++;
        setTimeout(disableCloseInterception, closeDisableIterations * 100);
    }
    //otherwise, it's probably ok.
}
disableCloseInterception();