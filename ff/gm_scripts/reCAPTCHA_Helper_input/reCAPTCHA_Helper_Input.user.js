// ==UserScript==
// @name			reCAPTCHA Helper input
// @version			0.4001
// @description		This automatically clicks on any recaptcha on the webpage and submits it directly after you solved it "https://github.com/eligrey/FileSaver.js/"
// @author			Royalgamer06 & Tackyou
// @include			*
// @grant			GM_xmlhttpRequest
// @grant			GM_setClipboard
// @namespace		https://greasyfork.org/scripts/18449-recaptcha-form-autosubmit-input/
// @require     	https://raw.githubusercontent.com/eligrey/FileSaver.js/master/FileSaver.js
// @downloadURL		
// @updateURL		
// ==/UserScript==

var dllink = null;
var domain = (window.location != window.parent.location) ? document.referrer.toString() : document.location.toString();
//	var domain = (window.location != window.parent.location) ? document.referrer.toString() : document.location.toString();
var dolist = domain.replace("http://","").replace("https://","").replace("http://www.","").replace("https://www.","").replace("www.","").split("/")[0];
//	var domain = domain.substr(0, domain.lastIndexOf("."))
var urlloc = null;
var result = null;
var listho = 'userscloud.com|uploadbank.com|filecyber.com|userscdn.com|datasbit.com|fileflares.com|xeupload.com|userscdn.com|heroupload.com|uploadify.net|sonifiles.com|europeup.com|debfile.com|fileupup.com|up-4ever.com|fistfast.com|fistfast.net|owndrives.com|houndify.com|google.com';
var autoho = 'houndify|houndify.com';

//	if(domain.indexOf('miped.ru') == -1 && domain.indexOf('indiegala') == -1) {	// You can exclude domains here (advanced)
	
if(domain.match(listho)) {
	if(location.href.indexOf('/recaptcha') > -1) {
		var focusmark = setInterval(function() {
			if(document.querySelectorAll('.recaptcha-checkbox-checkmark').length > 0) {
				if(domain.match(autoho)) {	//	if(domain.indexOf('houndify') == -1 && domain.indexOf('houndify.com') == -1) {
					document.querySelector('.recaptcha-checkbox-checkmark').click();
					document.querySelector('.rc-anchor.rc-anchor-normal.rc-anchor-light').scrollIntoView(false);
					clearInterval(focusmark);
				}else{
					// document.querySelector('.recaptcha-checkbox-checkmark').click();
					document.querySelector('.rc-anchor.rc-anchor-normal.rc-anchor-light').scrollIntoView(false);
					//	clearInterval(focusmark);
				}
			}
		}, 4000);
		var checkaudio = setInterval(function() {
			if(document.querySelectorAll('.rc-button.goog-inline-block.rc-button-audio').length > 0) {
				document.querySelector('.rc-button.goog-inline-block.rc-button-audio').click();
				document.querySelector('.rc-button.goog-inline-block.rc-button-audio').style.background  = "#0000FF";
				clearInterval(checkaudio);
			}
		}, 6000);
		var recolour = setInterval(function() {
			if(document.querySelectorAll('.recaptcha-checkbox-border').length > 0 ) {				
				document.querySelector('.recaptcha-checkbox-border').style.backgroundColor = '#FF12FF';console.log('[RC] REPLACE CHECK MARK BOX COLOUR');
				clearInterval(recolour);
			}  
		}, 100);
	}
}

//	CUSTOM FIX
if(domain.match('sonifiles.com')) {
	var coolhide = setInterval(function() {
		document.getElementById('countdown').style.visibility  = "hidden";
		document.getElementById('downloadbtn').style.display  = "block";
	}, 2000);
}

if(domain.match(listho)) {
	if(location.href.indexOf('/recaptcha') > -1) {
		var solvedcheck = setInterval(function() {
			var solveStatus = document.querySelector('.recaptcha-checkbox.goog-inline-block.recaptcha-checkbox-unchecked.rc-anchor-checkbox').getAttribute("aria-checked");
			if(solveStatus == 'true') {
				console.log('[RC] SOLVE STATUS : COMPLETE ' + (solveStatus) + ' ' + (dolist));
				GM_setClipboard('[RC] COMPLETE');
				clearInterval(solvedcheck);
			}else{
				console.log('[RC] SOLVE STATUS : TRY WORK ' + (solveStatus) + ' ' + (dolist));
				// console.log('[RC] TRY WORK : ');
			}					
		}, 3000);
	}
}

if(domain.match(listho)) {
	if(location.href.indexOf('frame')>-1){
		console.log('[RC] FRAME');
		var audio = setInterval(function(){
			if(document.querySelector('.rc-audiochallenge-play-button') != null){
				console.log('[RC] AUDIO FOUND');
				clearInterval(audio);
				setInterval(function(){
					var getmpeg = document.getElementById('audio-source').firstChild.getAttribute("src").replace("payload?c=","payload/audio.mp3?c=");
					if(getmpeg != null && getmpeg != dllink){
						document.getElementById('audio-response').style.backgroundColor = '#FFFF12';															//	console.log('[RC] RECOLOUR RESULT BOX');
						document.querySelector('.rc-audiochallenge-tdownload').style.display  = "none";															//	console.log('[RC] HIDDEN DOWNLOAD BUTTON');
						document.querySelector('.rc-button-reload').style.background  = "#FFFFFF";                                                              // 	console.log('[RC] CLEARED RELOAD BUTTON');
						document.querySelector('.verify-button-holder').querySelector('.rc-button-default.goog-inline-block').style.background  = "#4A90E2";	//	console.log('[RC] CLEARED SEPARATOR');
						document.querySelector('.rc-button-default.goog-inline-block').click();                                                                 //	console.log('[RC] CLICKED PLAY');	
						GM_setClipboard('');																													//	console.log('[RC] CLEARED RESULT');
						dllink = getmpeg;						
						urlloc = ('http://127.0.0.2:5000/captcha?' + 'web=' + (dolist) + '-' + (Math.random()) + '&' + 'sdk=' + 'gate' + '&' + 'url=' + (dllink));
						console.log('[RC] SENDING AUDIO');
						console.log('[RC] LINK : ' + (urlloc));
						console.log('[RC] HOST : ' + (dolist));
						GM_xmlhttpRequest({
						method: "GET",
						url: urlloc,
						timeout: 120000,
						onload: function(reponse) {
							var result = reponse.responseText.replace(/[^a-zA-Z ':]/g, "");   
							if(result != null){
								var json = null;
								try {
									// json.replace(/(\W)(buy)(\W)/gi, ' five nine ')
									// json.replace(/(\W)(fax)(\W)/gi, ' six ')
									// json.replace(/(\W)(an)(\W)/gi, ' seven eight ')
									// json.replace(/(\W)(by)(\W)/gi, ' five nine ')
									// json.replace(/(\W)(he)(\W)/gi, ' three eight ')
									// json.replace(/(\W)(hey)(\W)/gi, ' three six eight ')
									// json.replace(/(\W)(they)(\W)/gi, ' three six eight six ')
									// json.replace(/(\W)(that)(\W)/gi, ' six ')
									// json.replace(/(\W)(the)(\W)/gi, ' three ');
									// json.replace(/(\W)(not)(\W)/gi, ' nine ')
									// json.replace(/(\W)(alright)(\W)/gi, ' five ')
									// json.replace(/(\W)(hundred)(\W)/gi, ' eight six ')
									// json.replace(/(\W)(please)(\W)/gi, ' three ')
									// json.replace(/(\W)(k)(\W)/gi, ' eight ')
									// json.replace(/(\W)(a)(\W)/gi, ' eight ')
									// json.replace(/(\W)(i)(\W)/gi, ' five ')
									// json.replace(/(\W)(days)(\W)/gi, ' eight ')
									// json.replace(/(\W)(paid)(\W)/gi, ' eight ')
									// json.replace(/(\W)(bar)(\W)/gi, ' five ')
									// json.replace(/(\W)(flick)(\W)/gi, ' six ')
									// json.replace(/(\W)(girl)(\W)/gi, ' zero ')
									// json.replace(/(\W)(more)(\W)/gi, ' four ')
									// json.replace(/(\W)(morning)(\W)/gi, ' seven ')
									// json.replace(/(\W)(are)(\W)/gi, ' zero four')
									// json.replace(/(\W)(on)(\W)/gi, ' one ')
									// json.replace(/(\W)(so)(\W)/gi, ' two ')
									// json.replace(/(\W)(said)(\W)/gi, ' seven ')
									// json.replace(/(\W)(go)(\W)/gi, ' zero ')
									// ACCEPTED
									json = result.toLowerCase().replace(/\s/gi, '  ').replace(/^/gi, '  ').replace(/$/gi, '  ');
									json = json.replace(/(\W)(to  the  a)(\W)/gi, ' two  three  eight ');
									json = json.replace(/(\W)(the  row  the)(\W)/gi, ' zero  zero ');
									json = json.replace(/(\W)(you  know  the)(\W)/gi, ' zero  zero ');
									json = json.replace(/(\W)(in  the  morning)(\W)/gi, ' zero  nine ');
									json = json.replace(/(\W)(do  you  know)(\W)/gi, ' zero  nine ');
									json = json.replace(/(\W)(find  a  new)(\W)/gi, ' five ');
									json = json.replace(/(\W)(in  re)(\W)/gi, ' five  three ');
									json = json.replace(/(\W)(they  three)(\W)/gi, ' six  three ');
									json = json.replace(/(\W)(are  the )(\W)/gi, ' four  eight ');
									json = json.replace(/(\W)(are  they )(\W)/gi, ' four  eight ');
									json = json.replace(/(\W)(the  euro)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(the  europe)(\W)/gi, ' zero ');						
									json = json.replace(/(\W)(no  i)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(now  i)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(now  in)(\W)/gi, ' nine ');		
									json = json.replace(/(\W)(nah  i)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(who  is)(\W)/gi, ' three ');									
									json = json.replace(/(\W)(the  era)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(the  row)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(the  aero)(\W)/gi, ' zero ');		
									json = json.replace(/(\W)(the  room)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(the  rowe)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(the  hunt)(\W)/gi, ' zero ');	
									json = json.replace(/(\W)(the  hero)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(the  arrow)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(new  york)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(want  an)(\W)/gi, ' one ');
									json = json.replace(/(\W)(fack  i)(\W)/gi, ' six ');
									json = json.replace(/(\W)(do  you)(\W)/gi, ' six ');
									json = json.replace(/(\W)(you  know)(\W)/gi, ' zero ');	
									json = json.replace(/(\W)(i  ate)(\W)/gi, ' eight ');		
									json = json.replace(/(\W)(i  hate)(\W)/gi, ' eight ');									
									json = json.replace(/(\W)(by  is)(\W)/gi, ' five ');
									json = json.replace(/(\W)(i'm  sick)(\W)/gi, ' six ');
									json = json.replace(/(\W)(no)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(row)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(you)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(the)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(aero)(\W)/gi, ' zero ');	
									json = json.replace(/(\W)(buro)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(biro)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(nero)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(hero)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(hiro)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(nilo)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(jiro)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(relo)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(arrow)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(river)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(below)(\W)/gi, ' zero ')
									json = json.replace(/(\W)(hello)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(euro)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(year)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(years)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(there)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(yellow)(\W)/gi, ' zero ');
									json = json.replace(/(\W)(on)(\W)/gi, ' one ');
									json = json.replace(/(\W)(why)(\W)/gi, ' one ');
									json = json.replace(/(\W)(won)(\W)/gi, ' one ');
									json = json.replace(/(\W)(want)(\W)/gi, ' one ');
									json = json.replace(/(\W)(wine)(\W)/gi, ' one ');
									json = json.replace(/(\W)(worn)(\W)/gi, ' one ');
									json = json.replace(/(\W)(warm)(\W)/gi, ' one ');
									json = json.replace(/(\W)(to)(\W)/gi, ' two ');
									json = json.replace(/(\W)(do)(\W)/gi, ' two ');
									json = json.replace(/(\W)(who)(\W)/gi, ' two ');
									json = json.replace(/(\W)(tayo)(\W)/gi, ' two ');
									json = json.replace(/(\W)(he)(\W)/gi, ' three ');
									json = json.replace(/(\W)(re)(\W)/gi, ' three ');
									json = json.replace(/(\W)(we)(\W)/gi, ' three ');
									json = json.replace(/(\W)(pre)(\W)/gi, ' three ');
									json = json.replace(/(\W)(free)(\W)/gi, ' three ');
									json = json.replace(/(\W)(tree)(\W)/gi, ' three ');
									json = json.replace(/(\W)(they)(\W)/gi, ' three ');
									json = json.replace(/(\W)(route)(\W)/gi, ' three ');
									json = json.replace(/(\W)(third)(\W)/gi, ' three ');
									json = json.replace(/(\W)(thirty)(\W)/gi, ' three ');
									json = json.replace(/(\W)(really)(\W)/gi, ' three ');
									json = json.replace(/(\W)(or)(\W)/gi, ' four ');
									json = json.replace(/(\W)(of)(\W)/gi, ' four ');
									json = json.replace(/(\W)(are)(\W)/gi, ' four ');
									json = json.replace(/(\W)(for)(\W)/gi, ' four ');
									json = json.replace(/(\W)(born)(\W)/gi, ' four ')
									json = json.replace(/(\W)(pour)(\W)/gi, ' four ');
									json = json.replace(/(\W)(ford)(\W)/gi, ' four ');
									json = json.replace(/(\W)(fourth)(\W)/gi, ' four ');
									json = json.replace(/(\W)(porter)(\W)/gi, ' four ');
									json = json.replace(/(\W)(i)(\W)/gi, ' five ');
									json = json.replace(/(\W)(hi)(\W)/gi, ' five ');
									json = json.replace(/(\W)(by)(\W)/gi, ' five ');
									json = json.replace(/(\W)(buy)(\W)/gi, ' five ');
									json = json.replace(/(\W)(high)(\W)/gi, ' five ');
									json = json.replace(/(\W)(fine)(\W)/gi, ' five ');
									json = json.replace(/(\W)(find)(\W)/gi, ' five ');
									json = json.replace(/(\W)(drive)(\W)/gi, ' five ');
									json = json.replace(/(\W)(fifty)(\W)/gi, ' five ');
									json = json.replace(/(\W)(flight)(\W)/gi, ' five ');
									json = json.replace(/(\W)(de)(\W)/gi, ' six ');
									json = json.replace(/(\W)(day)(\W)/gi, ' six ');
									json = json.replace(/(\W)(hit)(\W)/gi, ' six ');
									json = json.replace(/(\W)(pic)(\W)/gi, ' six ');
									json = json.replace(/(\W)(son)(\W)/gi, ' six ');
									json = json.replace(/(\W)(sec)(\W)/gi, ' six ')
									json = json.replace(/(\W)(sex)(\W)/gi, ' six ');
									json = json.replace(/(\W)(set)(\W)/gi, ' six ');
									json = json.replace(/(\W)(say)(\W)/gi, ' six ');
									json = json.replace(/(\W)(pics)(\W)/gi, ' six ');
									json = json.replace(/(\W)(fack)(\W)/gi, ' six ');
									json = json.replace(/(\W)(pick)(\W)/gi, ' six ');
									json = json.replace(/(\W)(jelm)(\W)/gi, ' six ');
									json = json.replace(/(\W)(sacks)(\W)/gi, ' six ');
									json = json.replace(/(\W)(sixty)(\W)/gi, ' six ');
									json = json.replace(/(\W)(steele)(\W)/gi, ' six ');
									json = json.replace(/(\W)(seventh)(\W)/gi, ' seven ');
									json = json.replace(/(\W)(seventy)(\W)/gi, ' seven ');
									json = json.replace(/(\W)(have)(\W)/gi, ' seven ')
									json = json.replace(/(\W)(a)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(ed)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(aka)(\W)/gi, ' eight ')
									json = json.replace(/(\W)(ate)(\W)/gi, ' eight ')
									json = json.replace(/(\W)(ily)(\W)/gi, ' eight ')
									json = json.replace(/(\W)(hey)(\W)/gi, ' eight ')
									json = json.replace(/(\W)(made)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(hate)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(ain't)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(aight)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(phase)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(spain)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(paise)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(payne)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(eighty)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(eighteen)(\W)/gi, ' eight ');
									json = json.replace(/(\W)(niv)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(nye)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(not)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(now)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(nite)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(designs)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(nineteen)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(night)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(ninth)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(wine)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(know)(\W)/gi, ' nine ')
									json = json.replace(/(\W)(ninety)(\W)/gi, ' nine ');
									json = json.replace(/(\W)(bil)(\W)|(\W)(bill)(\W)|(\W)(rate)(\W)|(\W)(i'm)(\W)|(\W)(rate)(\W)|(\W)(and)(\W)|(\W)(rate)(\W)|(\W)(rates)(\W)|(\W)(that  every)(\W)|(\W)(this  is  it)(\W)|(\W)(hundred)(\W)|(\W)(biz)(\W)|(\W)(calle)(\W)|(\W)(hilton)(\W)/gi, '');
								} catch (e) {
								}
								if(json.match('one|two|three|four|five|six|seven|eight|nine|zero') && json.match('sorry|error|Sorry|Error') == null){
									var exact = json.replace(/\s*(one|two|three|four|five|six|seven|eight|nine|zero)\s*/gi, '');
									if (!exact) {
										if(domain.match(autoho)) {
											var inputedresult = setInterval(function(){
												clearInterval(inputedresult);
												document.getElementById('audio-response').style.backgroundColor = '#FFBB12';
												document.getElementById('audio-response').value = json.replace(/(\s)(zero)(\s)/gi, ' 0 ').replace(/(\s)(one)(\s)/gi, ' 1 ').replace(/(\s)(two)(\s)/gi, ' 2 ').replace(/(\s)(three)(\s)/gi, ' 3 ').replace(/(\s)(four)(\s)/gi, ' 4 ').replace(/(\s)(five)(\s)/gi, ' 5 ').replace(/(\s)(six)(\s)/gi, ' 6 ').replace(/(\s)(seven)(\s)/gi, ' 7 ').replace(/(\s)(eight)(\s)/gi, ' 8 ').replace(/(\s)(nine)(\s)/gi, ' 9 ').replace(/\s/gi, '').trim();
												console.log('[RC] INPUTED RESULT : ' + (json));
											}, 100);
										}else{
											var setclipboard = setInterval(function(){
												clearInterval(setclipboard);
												clip = json.replace(/(\s)(zero)(\s)/gi, ' 0 ').replace(/(\s)(one)(\s)/gi, ' 1 ').replace(/(\s)(two)(\s)/gi, ' 2 ').replace(/(\s)(three)(\s)/gi, ' 3 ').replace(/(\s)(four)(\s)/gi, ' 4 ').replace(/(\s)(five)(\s)/gi, ' 5 ').replace(/(\s)(six)(\s)/gi, ' 6 ').replace(/(\s)(seven)(\s)/gi, ' 7 ').replace(/(\s)(eight)(\s)/gi, ' 8 ').replace(/(\s)(nine)(\s)/gi, ' 9 ');
												GM_setClipboard(clip.replace(/\s/gi, ''));
												console.log('[RC] COPIED CLIPBOARD');
											}, 250);
										}
										var buttonclickverify = setInterval(function(){
											clearInterval(buttonclickverify);
											document.getElementById('audio-response').style.backgroundColor = '#12FF12';
											document.querySelector('.verify-button-holder').querySelector('.rc-button-default.goog-inline-block').style.background  = "#22FF22";
											if(domain.match(autoho)) {
												document.getElementById('recaptcha-verify-button').click();
												console.log('[RC] EXAC : OK');
											}else{
												//	document.getElementById('recaptcha-verify-button').click();
												console.log('[RC] EXAC : OK');
											}
										}, 750);
									}else{
										if(domain.match(autoho)) {
											var inputedresult = setInterval(function(){
												clearInterval(inputedresult);
												document.getElementById('audio-response').style.backgroundColor = '#FFBB12';
												document.getElementById('audio-response').value = json.replace(/(\s)(zero)(\s)/gi, ' 0 ').replace(/(\s)(one)(\s)/gi, ' 1 ').replace(/(\s)(two)(\s)/gi, ' 2 ').replace(/(\s)(three)(\s)/gi, ' 3 ').replace(/(\s)(four)(\s)/gi, ' 4 ').replace(/(\s)(five)(\s)/gi, ' 5 ').replace(/(\s)(six)(\s)/gi, ' 6 ').replace(/(\s)(seven)(\s)/gi, ' 7 ').replace(/(\s)(eight)(\s)/gi, ' 8 ').replace(/(\s)(nine)(\s)/gi, ' 9 ').replace(/\s/gi, '').trim();
												console.log('[RC] INEXACT RESULT : ' + (json));
											}, 100);
										}else{
											var setclipboard = setInterval(function(){
												clearInterval(setclipboard);
												clip = json.match(/\s*(one|two|three|four|five|six|seven|eight|nine|zero)\s*/gi).toString().replace(/[^a-zA-Z ':]/g, "").replace(/(\s)(zero)(\s)/gi, ' 0 ').replace(/(\s)(one)(\s)/gi, ' 1 ').replace(/(\s)(two)(\s)/gi, ' 2 ').replace(/(\s)(three)(\s)/gi, ' 3 ').replace(/(\s)(four)(\s)/gi, ' 4 ').replace(/(\s)(five)(\s)/gi, ' 5 ').replace(/(\s)(six)(\s)/gi, ' 6 ').replace(/(\s)(seven)(\s)/gi, ' 7 ').replace(/(\s)(eight)(\s)/gi, ' 8 ').replace(/(\s)(nine)(\s)/gi, ' 9 ');
												GM_setClipboard(clip.replace(/\s/gi, ''));
												console.log('[RC] COPIED CLIPBOARD');
											}, 250);
										}
										var buttonclickverify = setInterval(function(){
											clearInterval(buttonclickverify);
											document.getElementById('audio-response').style.backgroundColor = '#FF1212';
											document.querySelector('.verify-button-holder').querySelector('.rc-button-default.goog-inline-block').style.background  = "#FF2222";
											if(domain.match(autoho)) {
												document.getElementById('recaptcha-reload-button').click();
												console.log('[RC] EXAC : NO');
											}else{
												//	document.getElementById('recaptcha-reload-button').click();
												console.log('[RC] EXAC : NO');
											}
										}, 750);
									}
								}else{
									if(domain.match(autoho)) {
										var inexactresult = setInterval(function(){
											clearInterval(inexactresult);
											document.getElementById('audio-response').style.backgroundColor = '#FFBB12';
											document.getElementById('audio-response').value = json.replace(/(\s)(zero)(\s)/gi, ' 0 ').replace(/(\s)(one)(\s)/gi, ' 1 ').replace(/(\s)(two)(\s)/gi, ' 2 ').replace(/(\s)(three)(\s)/gi, ' 3 ').replace(/(\s)(four)(\s)/gi, ' 4 ').replace(/(\s)(five)(\s)/gi, ' 5 ').replace(/(\s)(six)(\s)/gi, ' 6 ').replace(/(\s)(seven)(\s)/gi, ' 7 ').replace(/(\s)(eight)(\s)/gi, ' 8 ').replace(/(\s)(nine)(\s)/gi, ' 9 ').replace(/\s/gi, '').trim();
											console.log('[RC] INEXACT RESULT : ' + (json));
										}, 100);
										var buttonclickreload = setInterval(function(){
											//	document.querySelector('.rc-button-reload').style.background  = "#FF1111";
											clearInterval(buttonclickreload);
											document.getElementById('recaptcha-reload-button').click();
											console.log('[RC] EXAC : ERROR');
										}, 5000);
									}else{
										var setclipboard = setInterval(function(){
											clearInterval(setclipboard);
											//	clip = json.match(/\s*(one|two|three|four|five|six|seven|eight|nine|zero)\s*/gi).toString().replace(/[^a-zA-Z ':]/g, "").replace(/(\s)(zero)(\s)/gi, ' 0 ').replace(/(\s)(one)(\s)/gi, ' 1 ').replace(/(\s)(two)(\s)/gi, ' 2 ').replace(/(\s)(three)(\s)/gi, ' 3 ').replace(/(\s)(four)(\s)/gi, ' 4 ').replace(/(\s)(five)(\s)/gi, ' 5 ').replace(/(\s)(six)(\s)/gi, ' 6 ').replace(/(\s)(seven)(\s)/gi, ' 7 ').replace(/(\s)(eight)(\s)/gi, ' 8 ').replace(/(\s)(nine)(\s)/gi, ' 9 ');
											//	GM_setClipboard(clip.replace(/\s/gi, ''));
											console.log('[RC] COPIED CLIPBOARD');
										}, 250);
										var buttonclickreload = setInterval(function(){
											//	document.querySelector('.rc-button-reload').style.background  = "#FF1111";
											clearInterval(buttonclickreload);
											//	document.getElementById('recaptcha-reload-button').click();
											console.log('[RC] EXAC : ERROR');
										}, 750);
									}
								}						
							}
						},
						ontimeout: function(timeout) {
							var buttonclickreload = setInterval(function(){
								clearInterval(buttonclickreload);
								document.getElementById('audio-response').style.backgroundColor = '#FF1111';
								//	document.querySelector('.rc-button-reload').style.background  = "#FF2222";
								if(domain.match(autoho)) {
									document.getElementById('recaptcha-reload-button').click();
								}else{
									//	document.getElementById('recaptcha-reload-button').click();									
								}
								console.log('[RC] EXAC : TIMEOUT');
							}, 750);
						}
						});
					}
				}, 1000);
			}
		}, 2000);
	}
}


//	function sentback(x){
//		alert(x);
//	}						
//	var request = new XMLHttpRequest();
//	request.open('POST', urlloc, true);
//	request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
//	request.onreadystatechange = function() {
//	    if(request.readyState == 4 && request.status == 200) {
//	        console.log('[RC] audio result received');
//	        var result = request.responseText;
//	        if(result.length>0){
//	            var json = null;
//	            try {
//	                json = JSON.parse(result);
//	            } catch (e) {
//	            }
//	            if(json !== null && json.confidence > 0.7){
//	                document.getElementById('audio-response').value = json.result;
//	                //document.getElementById('recaptcha-verify-button').click();
//	            }else{
//	                document.getElementById('audio-response').value = '???';
//	            }
//	        }
//	    }
//	};
//	request.send('audiocaptcha='+encodeURIComponent(dllink).replace(/!/g, '%21').replace(/'/g, '%27').replace(/\(/g, '%28').replace(/\)/g, '%29').replace(/\*/g, '%2A').replace(/%20/g, '+'));
//	}

	/*
	function click(x, y)
	{
		var myLayer = document.createElement('div');
		myLayer.style.position = 'absolute';
		myLayer.style.left = x+'px';
		myLayer.style.top = y+'px';
		myLayer.style.width = '2px';
		myLayer.style.height = '2px';
		myLayer.style.background = 'red';
		myLayer.style.zIndex = '9999999';
		myLayer.style.border = '3px double #FFF';
		myLayer.style.borderRadius = '10px';
		myLayer.style.pointerEvents = 'none';
		document.body.appendChild(myLayer);
	
		var ev = new MouseEvent('click', {
			'view': window,
			'bubbles': true,
			'cancelable': true,
			'screenX': x,
			'screenY': y
		});
		var el = document.elementFromPoint(x, y);
		el.dispatchEvent(ev);
		
		myLayer.click();
		
		myLayer.dispatchEvent(ev);
		
		console.log('click x:'+x+' y:'+y);
	}*/

