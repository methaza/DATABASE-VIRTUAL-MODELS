// ==UserScript==
// @name Disable redirection
// @version 1.00
// @description Disables redirection.
// @namespace http://superuser.com/questions/353339/firefox-disable-window-location-on-website/511703#511703
// @copyright 2012
// @author XP1
// @homepage https://github.com/XP1/
// @license Apache License, Version 2.0; http://www.apache.org/licenses/LICENSE-2.0
// @include http*://sonifiles.com/*
// @include http*://*.sonifiles.com/*
// ==/UserScript==

/*
 * Copyright 2012 XP1
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*jslint browser: true, vars: true, maxerr: 50, indent: 4 */
(function (opera) {
    "use strict";

    var isReplaced = false;

    function replaceJs(userJsEvent) {
        if (isReplaced) {
            return;
        }

        var element = userJsEvent.element;
        element.text = element.text.replace(/window\.location = "someotherpage\.html";/g, "");

        isReplaced = true;
    }

    opera.addEventListener("BeforeScript", function listener(userJsEvent) {
        if (isReplaced) {
            opera.removeEventListener("BeforeScript", listener, false);
            return;
        }

        replaceJs(userJsEvent);
    }, false);
}(this.opera))