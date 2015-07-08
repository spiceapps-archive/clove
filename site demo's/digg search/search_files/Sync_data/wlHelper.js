// Copyright 2007 Microsoft Corporation.  All rights reserved.

(function (){var cookieString = document.cookie;var acceptedHosts = [".live.com", ".msn.com", ".microsoft.com", ".xbox.com", ".atdmt.com"];var id_anid = null;var id_nap = null;var anidExpression = "(ANON=A=)([0-9a-fA-F]{32})(?=&E=)";var anonValue = null;var napExpression  = "NAP=(V=[0-9.]+&E=[0-9a-fA-F]+&C=([0-9a-zA-Z\-_$]+)&W=[0-9a-fA-F]+)(?=;|$)";var napValue = null;var expRegex = new RegExp(anidExpression);var regexMatch = expRegex.exec(cookieString);if (regexMatch){anonValue = regexMatch[2];}expRegex = new RegExp(napExpression);regexMatch = expRegex.exec(cookieString);if (regexMatch){napValue = regexMatch[1];}var aP = (anonValue == null && id_anid != null);var aE = (anonValue == null || (id_anid != null && id_anid.indexOf(anonValue) >= 0));var nP = (napValue == null && id_nap != null);var nE = (napValue == null || (id_nap != null && id_nap.indexOf(regexMatch[2]) >= 0));if (aP || nP){var windowHost = window.location.host;var validHost = false;for (var i = 0; i < acceptedHosts.length && !validHost; i++){validHost = false;var acceptedHost = acceptedHosts[i];for (var sIdx = 1; sIdx < acceptedHost.length; sIdx++){if (windowHost.charAt(windowHost.length - sIdx) != acceptedHost.charAt(acceptedHost.length - sIdx)){validHost = false;break;}else{validHost = true;}}}if (validHost == false){return;}var cookieDomain = "";if (location.host.length > 0){var hostTokens = location.host.split(".");if (hostTokens.length > 2){cookieDomain = "; domain=";for (var i = 1; i < hostTokens.length; i++){cookieDomain += "." + hostTokens[i];}}}var cookieSettings = typeof(cookieSettings) != "undefined" ? cookieSettings : cookieDomain + "; expires=Fri, 01 Jan 2010 00:00:00 GMT; path=/;";if (aP && nE){document.cookie = "ANON=" + id_anid + cookieSettings;}if (nP && aE){document.cookie = "NAP=" + id_nap + cookieSettings;}}})();