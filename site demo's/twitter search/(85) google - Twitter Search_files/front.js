if(!Array.forEach){Array.prototype.forEach=function(D,E){var C=E||window;for(var B=0,A=this.length;B<A;++B){D.call(C,this[B],B,this)}};Array.prototype.map=function(E,F){var D=F||window;var A=[];for(var C=0,B=this.length;C<B;++C){A.push(E.call(D,this[C],C,this))}return A}}if(!Array.remove){Array.remove=function(D,C,B){var A=D.slice((B||C)+1||D.length);D.length=C<0?D.length+C:C;return D.push.apply(D,A)}}Function.prototype.method=function(A,B){this.prototype[A]=B;return this};Function.prototype.augmentProto=function(A){for(key in A){this.prototype[key]=A[key]}return this};window.twttr=window.twttr||{};twttr.augmentObject=function(B,C){for(var A in C){B[A]=C[A]}return B};twttr.augmentObject(twttr,{namespaceOf:function(A){return twttr.is.object(A)?A:window},extend:function(B,C){var A=function(){};A.prototype=C.prototype;B.prototype=new A();B.prototype.constructor=B;B.uber=C.prototype;if(C.prototype.constructor==Object.prototype.constructor){C.prototype.constructor=C}},klass:function(A,B){return twttr.magic(A,B)},augmentAndExtend:function(A,B,C){ns=twttr.namespaceOf(A);ns[B]=function(){ns[B].uber.constructor.apply(this,arguments)};twttr.extend(ns[B],C);return ns[B]},auxo:function(C,D,B){var A=twttr.is.object(B)?B:twttr;return twttr.augmentAndExtend(A,C,D)},augmentString:function(C,A){var B=window;C.split(".").forEach(function(F,E,D){B=B[F]=B[F]||(twttr.is.def(D[E+1])?{}:A)});return B},magic:function(B,A){if(twttr.is.string(B)){return twttr.augmentString(B,A)}else{return twttr.augmentObject(B,A)}},inspect:function(B){console.clear();var C=$(B);var H=C.data("events");var A=0;var G=0;var E=[];var D=[];for(key in H){E.push(key);A++;D.push("\n*******************\n");D.push("Events for "+key+"\n\n");for(fn in H[key]){var F=H[key][fn];G++;D.push(F.toString()+"\n")}}console.log("************* Summary *************");console.log("for element",C);console.log(A+" types of events",E);console.log(G,"Total Event Listeners");console.log("Event listeners assigned to element");console.log(D.join(" "))},is:{bool:function(A){return typeof A==="boolean"},def:function(A){return !(typeof A==="undefined")},number:function(A){return typeof A==="number"&&isFinite(A)},fn:function(A){return typeof A==="function"},array:function(A){return A?this.number(A.length)&&this.fn(A.splice):false},string:function(A){return typeof A==="string"},object:function(A){return(A&&(typeof A==="object"||this.fn(A)))||false}}});if(!window.console){var names=["log","debug","info","warn","error","assert","dir","dirxml","group","groupEnd","time","timeEnd","count","trace","profile","profileEnd"];window.console={};for(var i=0;i<names.length;++i){window.console[names[i]]=function(){}}}function _(C,A){if(twttr.i18n){var B=twttr.i18n[C];if(B){C=B}}return replaceParams(C,A)}function replaceParams(B,A){if(A){for(var C in A){B=B.replace(new RegExp("\\%\\{"+C+"\\}","gi"),A[C])}}return B}var h=function(){var A=$("<div/>");return function(B){return B?A.text(B).html().replace(/\"/gi,"&quot;"):B}}();function unh(A){return A?A.replace(/&(amp;)+/g,"&").replace(/&[a-z]+;/gi,function(B){if(unh.HTML_ESCAPE_TOKENS[B]){return unh.HTML_ESCAPE_TOKENS[B]}return B}):A}window.unh.HTML_ESCAPE_TOKENS={"&lt;":"<","&gt;":">","&quot;":'"'};function addSlashes(A){return A.replace(/\'/g,"\\'").replace(/\"/g,'\\"')}var reverseString=function(A){return A?A.split("").reverse().join(""):A};var numberWithDelimiter=function(B,A,C){A=A?A:",";C=C?C:".";parts=(""+B).split(".");parts[0]=reverseString(reverseString(parts[0]).replace(/(\d\d\d)/g,"$1"+A));if(parts[0][0]==A){parts[0]=parts[0].substring(1)}return parts.join(C)};var timeAgo=function(C){if(!C){return false}var H=new Date();var G=new Date(C);if(document.all){G=Date.parse(C.replace(/( \+)/," UTC$1"))}var D=H-G;var B=1000,F=B*60,A=F*60;if(isNaN(D)||D<0){return false}var E=-1;$.each([5,10,20],function(){if(D<this*B){E=this;return false}});if(E!=-1){return _("less than %{time} seconds ago",{time:E})}if(D<B*40){return _("half a minute ago")}if(D<F){return _("less than a minute ago")}if(D<B*90){return _("1 minute ago")}if(D<F*45){return _("%{time} minutes ago",{time:Math.round(D/F)})}if(D<F*90){return _("about 1 hour ago")}if(D<A*24){return _("about %{time} hours ago",{time:Math.round(D/A)})}return false};var updateTimeAgo=function(){$(".timestamp").each(function(){var B=$(this);var A=timeAgo(B.meta().time);if(A&&B.find("*").length==0){B.html(A)}});$(".timestamp-title").each(function(){var B=$(this);var A=timeAgo(B.meta().time);if(A){B.attr("title",A)}})};var DEBUG=false;$.extend({log:function(A){if(window.console){console.log(A)}},debug:function(A){if(DEBUG){console.log(A)}},inspect:function(B){var A="{\n";for(var C in B){A+="\t"+C+": "+B[C]+"\n"}A+="}";console.log(A);return A}});(function(){if(document.all){if(/MSIE (\d+\.\d+);/.test(navigator.userAgent)){var A=new Number(RegExp.$1);if(A>=8){$.browser.msie8=true}else{if(A>=7){$.browser.msie7=true}else{$.browser.msie6=true}}}}})();var _tmp={};twttr.augmentObject(twttr,{timeouts:{},processJson:function(json){if(typeof (json)=="object"){var evals=[];$.each(json,function(selector,content){var c=selector.charAt(0);if(c=="$"){evals.push(content)}else{if(c=="!"){var notification=window[selector.substring(1)+"Notification"];if(notification){(new notification()).setMessage(content).show()}}else{var $contentPadded=$("<div></div>").html(content);var $content=$(selector,$contentPadded);if($content.length==1){$(selector).replaceWith($content)}else{$(selector).html(content)}$(selector).show()}}});$.each(evals,function(index,js){if(js){eval(js)}})}},truncateToHeight:function(B,C,G,A,E){if(!E){E={}}if(!E.minlength){E.minlength=0}if(E.minlength&&(B.length<E.minlength)){C.text(B);return B}var F=B.substring(0,E.minlength);for(var D=E.minlength;D<B.length;D++){F+=B.charAt(D);C.text(F+"...");if(A>=0&&G.height()>A){C.text(F=F.substring(0,F.length-1)+"...");return F}}C.text(F);return F},googleAnalytics:function(A){if(window.pageTracker){window.pageTracker._trackEvent("Ajax","refresh",A,null)}},trackPageView:function(C,B,D){if(window.pageTracker){var A;if(C){A=C.toString();if(B){A="/search/tweets/"+encodeURIComponent(h(page.query))}if(D){A=A+D}window.pageTracker._trackPageview(A)}else{window.pageTracker._trackPageview()}}},fadeAndReplace:function(A,B){$(A).fadeOut("medium",function(){$(A).html(B)});$(A).fadeIn("medium")},error:function(A){alert(A?A:_("Whoops! Something went wrong. Please refresh the page and try again!"))},loading:function(){$("#loader").fadeIn(200)},loaded:function(){$("#loader").fadeOut(200)},updateLocation:function(A){if(A){document.location.hash=A.replace(/^https?:\/\/.+?\//,"").replace(/#/gi,"%23").replace(/\s/gi,"+")}},NON_CHAR_KEY_CODES:[8,9,16,17,18,19,20,27,33,34,35,36,37,38,39,40,45,46,91,92,93],isNonCharKeyCode:function(A){return $.inArray(A.keyCode,twttr.NON_CHAR_KEY_CODES)!=-1||((A.ctrlKey||A.metaKey)&&$.inArray(A.keyCode,[67,88])!=-1)}});$.extend($.expr[":"],{onthepage:"($(elem).is(':visible') && $(elem).parents(':hidden').length == 0)"});$.fn.move=function(A){var B=$(this).html();$(this).remove();$(A).html(B)};$.fn.meta=function(){var B={type:"attr",name:"data"};var C=$(this);if(C.length==1){return C.metadata(B)}else{var A=[];C.each(function(){A.push($(this).metadata(B))});return A}};$.fn.isLoading=function(){$(this).addClass("loading")};$.fn.isLoaded=function(){$(this).removeClass("loading")};$.fn.replace_text=function(C,B){var A=$(this).html();if(A){$(this).html(A.replace(C,B))}};var pluralize=function(C,B,A){return C==1?B:A};var setDocumentTitle=function(A){document.title=unh(A)||""};var addCountToDocumentTitle=function(A){document.title=(A?"("+numberWithDelimiter(A)+") ":"")+document.title.replace(/\([^)]*[0-9]\)\s+/gi,"")};var getCurrentUserScreenName=function(){return page.user_screenname||$('meta[name="session-user-screen_name"]:first').get(0).content};var sessionUserIsPageUser=function(){try{return $('meta[name="session-user-screen_name"]:first').get(0).content==$('meta[name="page-user-screen_name"]:first').get(0).content}catch(A){return false}};$.fn.focusEnd=function(){return this.each(function(){var A=this;if(A.style.display!="none"){if($.browser.msie){A.focus();var B=A.createTextRange();B.collapse(false);B.select()}else{A.setSelectionRange(A.value.length,A.value.length);A.focus()}}})};$.fn.focusFirstTextField=function(){return this.find("input[type=text]:visible:enabled:first").focus().length>0},$.fn.focusFirstTextArea=function(){return this.find("textarea:visible:enabled:first").focus().length>0};$.fn.focusFirstTextElement=function(){return this.focusFirstTextField()||this.focusFirstTextArea()};$.fn.maxLength=function(A){return this.each(function(){$(this).keydown(function(B){return this.value.length<=A||twttr.isNonCharKeyCode(B)})})};$.fn.isSelectAll=function(A){return this.each(function(){var B=$(this);if(typeof (A)=="string"){var D=$(A).find("input[type=checkbox]")}else{var D=A}function C(){var E=true;D.each(function(){if(!this.checked){E=false;return false}});B.get(0).checked=E}B.click(function(){var E=B.get(0).checked;D.each(function(){this.checked=E});$(this).trigger("select-all-changed",E)});D.click(function(){C();$(this).trigger("checkbox-changed",this.checked)})})};Function.prototype.pBind=function(B){var A=this;return function(){return A.apply(B,arguments)}};$.fn.isHomeSearchForm=function(){return this.each(function(){var B=$(this);var A=$(B.find('input[type="text"]')[0]);var C=B.find("#home_search_submit");C.click(function(){B.submit();return false});B.submit(function(){var D=A.val();if(D!=""){C.addClass("loading");searchSummize(D,B,"processHomepageSearch");$("#trends_list li").removeClass("active")}return false});B.bind("loaded",null,function(D){C.removeClass("loading")})})};function processHomepageSearch(A){$(".wrapper, .wrapper-footer-ie").show();$("#signin_q").val(page.query);$(".logo").unbind();$("#trends, #trend_info span").remove();$("#big_signup").remove();processSummize(A)}window.SEARCH_CALLBACKS={summize:"processHomepageSearch",load:"pageHomepageLoadSearch",searchLink:"processHomepageSearchLink",trendLink:"processHomepageTrendLink",searchForm:"processHomepageSearchForm",hashtagLink:"processHomepageHashtagLink",inResultsLink:"processHomepageInResultsLink",more:"processHomepageSearchMore",refresh:"processHomepageSearchRefresh"};$.each(window.SEARCH_CALLBACKS,function(){window[this]=window.processHomepageSearch});function initializeSidebar(){action=page.query;if(action){var B=$.grep($("#trends_list li a"),function(C){return $(C).attr("name")==page.query})[0];if(B){var A=$(B).parent("li");if(A.length){A.addClass("active")}}}}twttr.updateLocation=function(A){if(A){A.replace(/^https?:\/\/.+?\//,"").replace(/\"/gi,"%22").replace(/#/gi,"%23").replace(/\s/gi,"+");var B=document.location.search;B.replace(/\"/gi,"%22").replace(/#/gi,"%23").replace(/\s/gi,"+");if("search"+B!=A){document.location.hash=A}}};function setTitleAndHeading(A){setDocumentTitle(_("%{query} - Twitter Search",{query:page.query}));if($("#timeline li").length){$("h2#timeline_heading").html(_("Realtime results for <strong>%{query}</strong>",{query:h(page.query)}))}else{$("h2#timeline_heading").html(_("No results for <strong>%{query}</strong>",{query:h(page.query)}))}}$.fn.isLanguageMenu=function(){return this.each(function(){var C=$(this);var A=$("#lf");var B=$(".language-select li + li");B.click(function(D){var E=B.offset();if($(window).height()<$("body").height()){C.css({top:E.top-C.height()-10,left:E.left})}else{C.css({top:E.top+B.height()-8,left:E.left})}C.toggle();return false});$(document).click(function(){C.hide()});C.find("li").click(function(){A.find("#lang").val(this.id);A.submit()})})};$.fn.isSigninMenu=function(){return this.each(function(){var A=$(this);$(".signin").click(function(){var B=$(this);var C=B.offset();A.css({top:C.top+B.height(),left:C.left-A.width()+B.width()});B.toggleClass("menu-open");A.toggle();if(B.hasClass("menu-open")){A.find("#username").focusEnd()}else{$("#home_search_q").focusEnd()}return false});A.mouseup(function(){return false});$(document).mouseup(function(B){if($(B.target).parent("a.signin").length==0){$(".signin").removeClass("menu-open");A.hide()}})})};$(function(){$("#home_search_q").focusEnd();$("#home_search").isHomeSearchForm();$(".language-menu").isLanguageMenu();$("#signin_menu").isSigninMenu();$("#trend_info img").tipsy({gravity:"s",offsetTop:-7});$("#trend_description img").tipsy({gravity:"s",offsetTop:-22});var A=$("#forgot_username_link");A.tipsy({gravity:"w",offsetLeft:7});A.bind("click",function(B){$("#username").focus();B.preventDefault()});$("#trends a").isSearchLink(SEARCH_CALLBACKS.trendLink);$("#trends_list a").isSearchLink(SEARCH_CALLBACKS.trendLink).bind("loading",null,function(B){$(this).parent("li").addClass("loading")}).bind("loaded",null,function(B){$(this).parent("li").removeClass("loading")});$(".logo").click(function(){return false})});var searchSummize=function(E,B,F,A){page.query=E;var D=$("body#search #timeline :first-child").attr("id");if(D&&page.retainTimeline){page.maxId=D.substring(7)}else{page.maxId=null}var C={q:page.query,rpp:20,maxId:page.maxId,callback:F||window.SEARCH_CALLBACKS.summize,layout:"none"};if(A){C.page=A}$("#side #q").val(E);B.trigger("loading");return $.ajax({url:page.summizeSearchUrl,data:C,dataType:"script",cache:false,complete:function(){$("#side #primary_nav li").removeClass("active");$("body").attr("id","search");var H="";if($("body.front").length){H=$("#trends_list li.active").length?"front/trends":"front/custom_search"}else{var G=$("#side li.active a.search-link").parents("div#trends, div#saved_searches");H=G.length==0?$("#side div#custom_search.active").attr("id"):G.attr("id")}twttr.trackPageView($("body").attr("id"),(page.query&&page.query.length>0?page.query:null),"/"+H+(!page.retainTimeline?"/ajax":"/ajax/more"));B.trigger("loaded");page.retainTimeline=null;page.isTimelineChange=false}})};var processSummize=function(B){var J=page.trendDescriptions[page.query];if(J){$("#trend_info").hide();$("#trend_description span").text(_("%{trend} is a popular topic on Twitter right now.",{trend:J[0]}));$("#trend_description p").html(J[1]);$("#trend_description").show()}else{$("#trend_description").hide();$("#trend_info").show()}var H=$(B);var M=$(".homepage #timeline").length;var C=M&&!$(".homepage #timeline li").length;var F=$("#timeline");var L=(page.query!="");$("body").attr("id","search");var N=1;$pageBtn=H.find(".paginator a.next");var E;if($pageBtn.length){E=$pageBtn.attr("href");E.match(/\?.*page=([0-9]+)/gi);N=RegExp.$1;N=N?parseInt(N):1}var D=[];if(L){if(!page.retainTimeline){$("#timeline").empty();$("#pagination").empty();$("#content .no-results").remove();$("#results_update").hide()}D=renderResultsFromSummize(H,F,M)}$("#container, #side_base").show();F.find(".msgtxt a").each(twttr.appendClassesToSearchResults);F.find(".msgtxt").prev().addClass("tweet-url screen-name");F.find("span.vcard a").addClass("tweet-url profile-pic");F.find(".status-body a,.vcard a").each(function(){var Q=$(this);var O=Q.attr("href");if(O.match(/^\/search\?q=([^&]+)/)){Q.removeAttr("target");var P=decodeURIComponent(RegExp.$1);Q.attr("title",P);Q.isSearchLink(P.match(/^#/)?SEARCH_CALLBACKS.hashtagLink:SEARCH_CALLBACKS.inResultsLink)}else{if(O.match(/^https?:\/\/twitter\.com/)){Q.removeAttr("target")}}});if(page.searchResults=(D.length>0&&L)){if(!M){enfavoriteSummize(D)}page.maxId=D[0];if(E){$("#pagination").empty().html('<a id="search_more" class="round more" rel="next" href="'+E+'">'+_("more")+"</a>").find("a").isSearchMoreButton(M)}else{$("#pagination").empty().html('<p class="no-more-tweets">'+_("Older tweets are temporarily unavailable.")+"</p>")}}else{var I=[_("Try a more general search."),_("Try using different words.")];var K='<div class="no-results">'+_("Suggestions:")+"<ol>";for(var G=0;G<I.length;G++){K+="<li>"+_(I[G])+"</li>"}K+="</ol></div>";setTimeout(function(){$("#timeline_heading").after(K)},1)}twttr.updateLocation("search?q="+encodeURIComponent(page.query));initializeSidebar();var A=$("#sidebar_search_q, #home_search_q");if(A.val()!=page.query){A.val(page.query);A.css("color","#000")}onPageChange(C);$("#side #rssfeed a.search-rss").attr("href","http://search.twitter.com/search.atom?q="+h(encodeURIComponent(page.query)));summizeRefresh()};if(!window.SEARCH_CALLBACKS){window.SEARCH_CALLBACKS={summize:"processSummize",load:"pageLoadSearch",searchLink:"processSearchLink",trendLink:"processTrendLink",savedSearchLink:"processSavedSearchLink",searchForm:"processSearchForm",hashtagLink:"processHashtagLink",inResultsLink:"processInResultsLink",more:"processSearchMore",refresh:"processSearchRefresh"};$.each(window.SEARCH_CALLBACKS,function(){window[this]=window.processSummize})}function renderResultsFromSummize(C,B,A){var D=[];C.find(".result").each(function(){var I=$(this);I.find(".location,.thread,.to_av,p.clearleft,.expand,#share").remove();var F=$(I.find(".avatar").get(0));F.replaceWith('<span class="thumb vcard author">'+F.html()+"</span>");var K=$(I.find(".info").get(0));var L,G,E;K.find("a.lit").each(function(){E=$(this).attr("href");var O=E.match(/\/(\w+)\/statuses\/(\d+)/);L=O[2];D.push(L);G=O[1]});var H=K.find(".source").remove();K.find("a").remove();K.html('<a href="'+E+'">'+K.html()+"</a>");K.append(H);var N='<span class="meta">'+K.html().replace(/\u00B7/g,"")+"</span>";K.remove();var M=$(I.find(".msg").get(0));M.replaceWith('<span class="status-body">'+($.browser.msie6?'<img src="http://s.twimg.com/a/1260393960/images/white.png" width="1" height="50" align="left">':"")+M.html().replace(/a>\s*:\s*<span/,"a> <span")+N+"</span>");var J=I.html();if(!A){J+='<span class="actions"><a href="#" class="fav-action non-fav" id="status_star_'+L+'"> &nbsp; </a><a href="/home?status=@'+G+"%20&in_reply_to_status_id="+L+"&in_reply_to="+G+'" class="reply"> &nbsp; </a></span>'}B.append('<li class="hentry status search_result u-'+G+'" id="status_'+L+'">'+J+"</li>")});return D}function enfavoriteSummize(A){if(page.loggedIn&&A.length>0){$timeline=$("#timeline");$.ajax({type:"POST",dataType:"json",url:"/favourings/intersect_for_search",data:{authenticity_token:twttr.form_authenticity_token,"status_id[]":A,twttr:true},beforeSend:null,success:function(B){$.map(B,function(C){$timeline.find("#status_"+C+" .non-fav").addClass("fav").removeClass("non-fav")})},complete:null})}}function summizeRefresh(){if(page.timelineRefresher){page.timelineRefresher.stop();page.timelineRefresher=null;addCountToDocumentTitle()}var B=$("#results_update");B.data("count",0);var A=$("#new_results_notification").meta().search;if(page.summizeRefresher||$("#results_update").length==0){return }page.newResults=null;page.summizeRefresher=new Occasionally(A.delay*1000,A.max_delay*1000,function(){var C=false;$.ajax({dataType:"script",url:page.summizeSearchUrl,data:{q:page.query,since_id:page.maxId,refresh:true,callback:"processSummizeRefresh"},cache:false,callback:null})},function(){return page.newResults},A.decay);page.summizeRefresher.start()}function processSummizeRefresh(B){if(decodeURIComponent(B.query).replace(/\+/g," ")==page.query&&B.total){page.maxId=B.max_id;var C=page.summizeRefreshResults=(page.summizeRefreshResults||0)+B.total;var A=$("#results_update").is(":visible")?"":' style="display:none;"';var D='<a id="results_update" class="minor-notification"'+A+">";D+=(C==1)?_("1 more tweet since you started searching."):_("%{results_count} more tweets since you started searching.",{results_count:numberWithDelimiter(C)});D+="</a>";$("#results_update").replaceWith(D);$("#results_update:hidden").slideDown();$("#results_update").attr("title",page.query).attr("href","/search?q="+encodeURIComponent(h(page.query))).isSearchLink(SEARCH_CALLBACKS.refresh).click(function(){addCountToDocumentTitle();return false});if(C){addCountToDocumentTitle(C)}page.newResults=true}else{page.newResults=false}}$.fn.isSearchMoreButton=function(A){return this.each(function(){var B=$(this);B.click(function(){B.blur();var D=B.attr("href");D.match(/\?.*page=([0-9]+)/gi);var C=RegExp.$1;page.retainTimeline=true;$("#timeline li:last-child").addClass("last-on-page");searchSummize(page.query,B,SEARCH_CALLBACKS.more,C);B.addClass("loading").html("");return false})})};function onPageChange(A){var B=$("body").attr("id");setTitleAndHeading(B);if(!A){if(page.summizeRefresher){page.summizeRefresher.stop();page.summizeRefresher=null;page.summizeRefreshResults=null}$("#results_update").hide();$(".no-results").remove();$("#new_results_count").html("0")}if(B=="list"||B=="list_show"){B=(window.location.hash||window.location.pathname).replace(/^#/,"").replace(/^([^\/])/,"/$1");if(B.indexOf("/list")!=0){B="/list"+B}}twttr.trackPageView(B,(page.query&&page.query.length>0?page.query:null),A?null:"/ajax")}$.fn.isSearchLink=function(A){return this.each(function(){var B=$(this);B.click(function(C){C.preventDefault();if($.browser.msie){this.hideFocus=true}if(page.isTimelineChange&&page.currentTimelineChange){page.currentTimelineChange.abort();page.$oldTimelineLink.trigger("aborted");page.isTimelineChange=false}page.isTimelineChange=true;page.currentTimelineChange=searchSummize(B.attr("name")?B.attr("name"):B.attr("title"),B,A);if(B.parents("#side").length>0){$("#side ul.sidebar-menu li").removeClass("active");B.parent("li").addClass("active")}$("#trends_list li.active a").removeClass("active")})})};$.fn.isSearchForm=function(){return this.each(function(){var B=$(this);var A=$(B.find('input[type="text"]')[0]);var C=B.find("#sidebar_search_submit");A.Watermark(_("Search")).focus(function(){A.select();return true});C.click(function(){B.submit()});B.submit(function(){var D=A.val();if(D!=""){C.addClass("loading");searchSummize(D,B,SEARCH_CALLBACKS.searchForm)}$("#side ul.sidebar-menu li").removeClass("active");$("#side #custom_search").addClass("active");return false});B.bind("loaded",null,function(D){C.removeClass("loading")})})};$(document).ready(function(){$("#tweet_search_submit").click(function(){$("#tweet_search").submit()});$("#content #trend_description img").tipsy({gravity:"s"});page.trendDescriptions={};$("#trends a").each(function(){var A=$(this);var C=A.parent().find("em");if(C.length){var B=A.text();var D=C.text().replace(new RegExp(B.replace(/([^\w])/gi,"\\$1"),"gi"),"<strong>"+B+"</strong>");page.trendDescriptions[A.attr("title")]=[B,D]}});if($("body").attr("id")=="search"){onCondition(function(){return page.summizeResults},function(){window[SEARCH_CALLBACKS.summize](page.summizeResults)})}});twttr.appendClassesToSearchResults=function(){var A=$(this);A.addClass("tweet-url");if(A.text().match(/^@/)){A.addClass("username")}else{if(A.text().match(/^#/)){A.addClass("hashtag")}else{A.addClass("web")}}};(function(){jQuery.inherits=function(A,C){function B(){}B.prototype=C.prototype;A.prototype=new B();A.prototype.constructor=A}})();(function(){jQuery.fn.equals=function(A){return this.get(0)==A.get(0)}})();(function(){jQuery.fn.hasParent=function(A){var B=false;this.parents().map(function(){if($(this).equals(A)){B=true}});return B}})();function Notification(B){this.$bar=jQuery('<div class="notification-bar"></div>');this.$barContainer=jQuery('<div class="notification-bar-container"></div>');this.$barContents=jQuery('<div class="notification-bar-contents"></div>');this.$barBackground=jQuery('<div class="notification-bar-bkg"></div>');this.$message=jQuery('<div class="message"></div>');this.$bar.hide();this.$barBackground.hide();var A=this;this.$bar.click(function(C){A.removeAfterEvent(C)});this.className=B}Notification.SLIDE_SPEED_IN_MS=300;Notification.prototype.remove=function(){var A=this;this.slideUp(function(){A.$bar.remove();A.$barBackground.remove();window.clearTimeout(A.timeout)})};Notification.prototype.removeAfterEvent=function(B){var A=$(B.target);if(A.get(0).nodeName.toLowerCase()=="a"&&A.hasParent(this.$message)){return }this.remove()};Notification.prototype.setMessage=function(A){this.msg=A;return this};Notification.prototype.show=function(){this.$message.addClass(this.className).html(this.msg);this.$barContainer.append(this.$barBackground).append(this.$bar.append(this.$barContents.append(this.$message)));jQuery("#notifications").append(this.$barContainer);this.$barBackground.height(this.$bar.height());this.showBar();if(this.onShow){this.onShow()}return this};Notification.prototype.removeInMilliseconds=function(){var A=this;this.timeout=window.setTimeout(function(){A.remove()},A.timeoutInMilliseconds)};Notification.prototype.showBar=function(){this.$bar.show();this.$barBackground.show()};Notification.prototype.onShow=function(){this.removeInMilliseconds()};Notification.prototype.slideUp=function(A){this.$bar.slideUp(Notification.SLIDE_SPEED_IN_MS);this.$barBackground.slideUp(Notification.SLIDE_SPEED_IN_MS,A)};function ShortNotification(){Notification.call(this,"message-info");this.timeoutInMilliseconds=3000}jQuery.inherits(ShortNotification,Notification);ShortNotification.prototype.showBar=function(){this.$bar.slideDown(Notification.SLIDE_SPEED_IN_MS);this.$barBackground.slideDown(Notification.SLIDE_SPEED_IN_MS)};function InfoNotification(){Notification.call(this,"message-info");this.timeoutInMilliseconds=6000}jQuery.inherits(InfoNotification,Notification);InfoNotification.prototype.showBar=function(){this.$bar.slideDown(Notification.SLIDE_SPEED_IN_MS);this.$barBackground.slideDown(Notification.SLIDE_SPEED_IN_MS)};function ProgressNotification(){Notification.call(this,"message-progress");this.timeoutInMilliseconds=1000}jQuery.inherits(ProgressNotification,Notification);ProgressNotification.prototype.setProgressMessage=function(A){return this.setMessage(A)};ProgressNotification.prototype.setCompletedMessage=function(A){this.completedMsg=A;return this};ProgressNotification.prototype.onShow=function(){};ProgressNotification.prototype.cancel=function(){this.timeoutInMilliseconds=0;this.removeInMilliseconds()};ProgressNotification.prototype.done=function(){this.$message.addClass("message-progress-done").removeClass(this.className).html(this.completedMsg);this.removeInMilliseconds()};function ErrorNotification(){Notification.call(this,"message-error");this.timeoutInMilliseconds=8000}jQuery.inherits(ErrorNotification,Notification);function Occasionally(A,D,C,B,E){this.interval=A;this.maxDecayTime=D;this.job=C;this.decayCallback=B;this.timesRun=0;this.decayRate=1;this.decayMultiplier=E||1.25;this.maxRequests=360}Occasionally.prototype.start=function(){this.stop();this.run()};Occasionally.prototype.stop=function(){if(this.worker){window.clearTimeout(this.worker)}};Occasionally.prototype.run=function(){var A=this;this.decayRate=this.decayCallback()?Math.max(1,this.decayRate/this.decayMultiplier):this.decayRate*this.decayMultiplier;var B=this.interval*this.decayRate;B=(B>=this.maxDecayTime)?this.maxDecayTime:B;this.worker=window.setTimeout(function(){A.execute()},Math.floor(B))};Occasionally.prototype.execute=function(){this.job();if(++this.timesRun<this.maxRequests){this.run()}};twttr.countClick=function(){var A=twttr.createTrackingParameters(this);twttr.asyncClickCount(A)};twttr.asyncClickCount=function(A){(new Image()).src="/abacus?"+$.param(A)};twttr.createTrackingParameters=function(F){var B=$(F);var A=function(){var K=B.attr("class");var I=["hashtag","profile-pic","screen-name","username","web"];for(var J in I){if(K.indexOf(I[J])!==-1){return I[J]}}}();var E=B.closest(".status").find(".meta").children("a").get(0).href.split("/");var G=E[E.length-1];var H=$('meta[name="session-userid"]');var D=H.attr("content")||-1;var C=twttr.form_authenticity_token||$('input[name="authenticity_token"]').attr("value");return{url:F.href,linkType:A,tweetId:G,userId:D,authenticity_token:C,time:(new Date).getTime()}};$(document).ready(function(){var A=$("#content a.tweet-url");A.live("mousedown",twttr.countClick)});/*
 * Copyright (c) 2007 Josh Bush (digitalbush.com)
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:

 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 * Version: Beta 1
 * Release: 2007-06-01
 */
(function($) {
	var map=new Array();
	$.Watermark = {
		ShowAll:function(){
			for (var i=0;i<map.length;i++){
				if(map[i].obj.val()==""){
					map[i].obj.val(map[i].text);
					map[i].obj.css("color",map[i].WatermarkColor);
				}else{
				    map[i].obj.css("color",map[i].DefaultColor);
				}
			}
		},
		HideAll:function(){
			for (var i=0;i<map.length;i++){
				if(map[i].obj.val()==map[i].text)
					map[i].obj.val("");
			}
		}
	}

	$.fn.Watermark = function(text,color) {
		if(!color)
			color="#aaa";
		return this.each(
			function(){
				var input=$(this);
				var defaultColor=input.css("color");
				map[map.length]={text:text,obj:input,DefaultColor:defaultColor,WatermarkColor:color};
				function clearMessage(){
					if(input.val()==text)
						input.val("");
					input.css("color",defaultColor);
				}

				function insertMessage(){
					if(input.val().length==0 || input.val()==text){
						input.val(text);
						input.css("color",color);
					}else
						input.css("color",defaultColor);
				}

				input.focus(clearMessage);
				input.blur(insertMessage);
				input.change(insertMessage);

				insertMessage();
			}
		);
	};
})(jQuery);
/*
 * Cookie plugin
 *
 * Copyright (c) 2006 Klaus Hartl (stilbuero.de)
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 */
jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        // CAUTION: Needed to parenthesize options.path and options.domain
        // in the following expressions, otherwise they evaluate to undefined
        // in the packed version for some reason...
        var path = options.path ? '; path=' + (options.path) : '';
        var domain = options.domain ? '; domain=' + (options.domain) : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};
/*
 * jQuery Color Animations
 * Copyright 2007 John Resig
 * Released under the MIT and GPL licenses.
 */

(function(jQuery){

	// We override the animation for all of these color styles
	jQuery.each(['backgroundColor', 'borderBottomColor', 'borderLeftColor', 'borderRightColor', 'borderTopColor', 'color', 'outlineColor', 'borderColor'], function(i,attr){
		jQuery.fx.step[attr] = function(fx){
			if ( fx.state == 0 ) {
				fx.start = getColor( fx.elem, attr );
				fx.end = getRGB( fx.end );
			}

			fx.elem.style[attr] = "rgb(" + [
				Math.max(Math.min( parseInt((fx.pos * (fx.end[0] - fx.start[0])) + fx.start[0]), 255), 0),
				Math.max(Math.min( parseInt((fx.pos * (fx.end[1] - fx.start[1])) + fx.start[1]), 255), 0),
				Math.max(Math.min( parseInt((fx.pos * (fx.end[2] - fx.start[2])) + fx.start[2]), 255), 0)
			].join(",") + ")";
		}
	});

	// Color Conversion functions from highlightFade
	// By Blair Mitchelmore
	// http://jquery.offput.ca/highlightFade/

	// Parse strings looking for color tuples [255,255,255]
	function getRGB(color) {
		var result;

		// Check if we're already dealing with an array of colors
		if ( color && color.constructor == Array && color.length == 3 )
			return color;

		// Look for rgb(num,num,num)
		if (result = /rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(color))
			return [parseInt(result[1]), parseInt(result[2]), parseInt(result[3])];

		// Look for rgb(num%,num%,num%)
		if (result = /rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(color))
			return [parseFloat(result[1])*2.55, parseFloat(result[2])*2.55, parseFloat(result[3])*2.55];

		// Look for #a0b1c2
		if (result = /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(color))
			return [parseInt(result[1],16), parseInt(result[2],16), parseInt(result[3],16)];

		// Look for #fff
		if (result = /#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(color))
			return [parseInt(result[1]+result[1],16), parseInt(result[2]+result[2],16), parseInt(result[3]+result[3],16)];

		// Otherwise, we're most likely dealing with a named color
		return colors[jQuery.trim(color).toLowerCase()];
	}

	function getColor(elem, attr) {
		var color;

		do {
			color = jQuery.curCSS(elem, attr);

			// Keep going until we find an element that has color, or we hit the body
			if ( color != '' && color != 'transparent' || jQuery.nodeName(elem, "body") )
				break;

			attr = "backgroundColor";
		} while ( elem = elem.parentNode );

		return getRGB(color);
	};

	// Some named colors to work with
	// From Interface by Stefan Petre
	// http://interface.eyecon.ro/

	var colors = {
		aqua:[0,255,255],
		azure:[240,255,255],
		beige:[245,245,220],
		black:[0,0,0],
		blue:[0,0,255],
		brown:[165,42,42],
		cyan:[0,255,255],
		darkblue:[0,0,139],
		darkcyan:[0,139,139],
		darkgrey:[169,169,169],
		darkgreen:[0,100,0],
		darkkhaki:[189,183,107],
		darkmagenta:[139,0,139],
		darkolivegreen:[85,107,47],
		darkorange:[255,140,0],
		darkorchid:[153,50,204],
		darkred:[139,0,0],
		darksalmon:[233,150,122],
		darkviolet:[148,0,211],
		fuchsia:[255,0,255],
		gold:[255,215,0],
		green:[0,128,0],
		indigo:[75,0,130],
		khaki:[240,230,140],
		lightblue:[173,216,230],
		lightcyan:[224,255,255],
		lightgreen:[144,238,144],
		lightgrey:[211,211,211],
		lightpink:[255,182,193],
		lightyellow:[255,255,224],
		lime:[0,255,0],
		magenta:[255,0,255],
		maroon:[128,0,0],
		navy:[0,0,128],
		olive:[128,128,0],
		orange:[255,165,0],
		pink:[255,192,203],
		purple:[128,0,128],
		violet:[128,0,128],
		red:[255,0,0],
		silver:[192,192,192],
		white:[255,255,255],
		yellow:[255,255,0]
	};

})(jQuery);
/* Copyright (c) 2008 Brandon Aaron (http://brandonaaron.net)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * Version: 1.0.3
 * Requires jQuery 1.1.3+
 * Docs: http://docs.jquery.com/Plugins/livequery
 */

(function($) {

$.extend($.fn, {
	livequery: function(type, fn, fn2) {
		var self = this, q;

		// Handle different call patterns
		if ($.isFunction(type))
			fn2 = fn, fn = type, type = undefined;

		// See if Live Query already exists
		$.each( $.livequery.queries, function(i, query) {
			if ( self.selector == query.selector && self.context == query.context &&
				type == query.type && (!fn || fn.$lqguid == query.fn.$lqguid) && (!fn2 || fn2.$lqguid == query.fn2.$lqguid) )
					// Found the query, exit the each loop
					return (q = query) && false;
		});

		// Create new Live Query if it wasn't found
		q = q || new $.livequery(this.selector, this.context, type, fn, fn2);

		// Make sure it is running
		q.stopped = false;

		// Run it immediately for the first time
		q.run();

		// Contnue the chain
		return this;
	},

	expire: function(type, fn, fn2) {
		var self = this;

		// Handle different call patterns
		if ($.isFunction(type))
			fn2 = fn, fn = type, type = undefined;

		// Find the Live Query based on arguments and stop it
		$.each( $.livequery.queries, function(i, query) {
			if ( self.selector == query.selector && self.context == query.context &&
				(!type || type == query.type) && (!fn || fn.$lqguid == query.fn.$lqguid) && (!fn2 || fn2.$lqguid == query.fn2.$lqguid) && !this.stopped )
					$.livequery.stop(query.id);
		});

		// Continue the chain
		return this;
	}
});

$.livequery = function(selector, context, type, fn, fn2) {
	this.selector = selector;
	this.context  = context || document;
	this.type     = type;
	this.fn       = fn;
	this.fn2      = fn2;
	this.elements = [];
	this.stopped  = false;

	// The id is the index of the Live Query in $.livequery.queries
	this.id = $.livequery.queries.push(this)-1;

	// Mark the functions for matching later on
	fn.$lqguid = fn.$lqguid || $.livequery.guid++;
	if (fn2) fn2.$lqguid = fn2.$lqguid || $.livequery.guid++;

	// Return the Live Query
	return this;
};

$.livequery.prototype = {
	stop: function() {
		var query = this;

		if ( this.type )
			// Unbind all bound events
			this.elements.unbind(this.type, this.fn);
		else if (this.fn2)
			// Call the second function for all matched elements
			this.elements.each(function(i, el) {
				query.fn2.apply(el);
			});

		// Clear out matched elements
		this.elements = [];

		// Stop the Live Query from running until restarted
		this.stopped = true;
	},

	run: function() {
		// Short-circuit if stopped
		if ( this.stopped ) return;
		var query = this;

		var oEls = this.elements,
			els  = $(this.selector, this.context),
			nEls = els.not(oEls);

		// Set elements to the latest set of matched elements
		this.elements = els;

		if (this.type) {
			// Bind events to newly matched elements
			nEls.bind(this.type, this.fn);

			// Unbind events to elements no longer matched
			if (oEls.length > 0)
				$.each(oEls, function(i, el) {
					if ( $.inArray(el, els) < 0 )
						$.event.remove(el, query.type, query.fn);
				});
		}
		else {
			// Call the first function for newly matched elements
			nEls.each(function() {
				query.fn.apply(this);
			});

			// Call the second function for elements no longer matched
			if ( this.fn2 && oEls.length > 0 )
				$.each(oEls, function(i, el) {
					if ( $.inArray(el, els) < 0 )
						query.fn2.apply(el);
				});
		}
	}
};

$.extend($.livequery, {
	guid: 0,
	queries: [],
	queue: [],
	running: false,
	timeout: null,

	checkQueue: function() {
		if ( $.livequery.running && $.livequery.queue.length ) {
			var length = $.livequery.queue.length;
			// Run each Live Query currently in the queue
			while ( length-- )
				$.livequery.queries[ $.livequery.queue.shift() ].run();
		}
	},

	pause: function() {
		// Don't run anymore Live Queries until restarted
		$.livequery.running = false;
	},

	play: function() {
		// Restart Live Queries
		$.livequery.running = true;
		// Request a run of the Live Queries
		$.livequery.run();
	},

	registerPlugin: function() {
		$.each( arguments, function(i,n) {
			// Short-circuit if the method doesn't exist
			if (!$.fn[n]) return;

			// Save a reference to the original method
			var old = $.fn[n];

			// Create a new method
			$.fn[n] = function() {
				// Call the original method
				var r = old.apply(this, arguments);

				// Request a run of the Live Queries
				$.livequery.run();

				// Return the original methods result
				return r;
			}
		});
	},

	run: function(id) {
		if (id != undefined) {
			// Put the particular Live Query in the queue if it doesn't already exist
			if ( $.inArray(id, $.livequery.queue) < 0 )
				$.livequery.queue.push( id );
		}
		else
			// Put each Live Query in the queue if it doesn't already exist
			$.each( $.livequery.queries, function(id) {
				if ( $.inArray(id, $.livequery.queue) < 0 )
					$.livequery.queue.push( id );
			});

		// Clear timeout if it already exists
		if ($.livequery.timeout) clearTimeout($.livequery.timeout);
		// Create a timeout to check the queue and actually run the Live Queries
		$.livequery.timeout = setTimeout($.livequery.checkQueue, 20);
	},

	stop: function(id) {
		if (id != undefined)
			// Stop are particular Live Query
			$.livequery.queries[ id ].stop();
		else
			// Stop all Live Queries
			$.each( $.livequery.queries, function(id) {
				$.livequery.queries[ id ].stop();
			});
	}
});

// Register core DOM manipulation methods
$.livequery.registerPlugin('append', 'prepend', 'after', 'before', 'wrap', 'attr', 'removeAttr', 'addClass', 'removeClass', 'toggleClass', 'empty', 'remove');

// Run Live Queries when the Document is ready
$(function() { $.livequery.play(); });


// Save a reference to the original init method
var init = $.prototype.init;

// Create a new init method that exposes two new properties: selector and context
$.prototype.init = function(a,c) {
	// Call the original init and save the result
	var r = init.apply(this, arguments);

	// Copy over properties if they exist already
	if (a && a.selector)
		r.context = a.context, r.selector = a.selector;

	// Set properties
	if ( typeof a == 'string' )
		r.context = c || document, r.selector = a;

	// Return the result
	return r;
};

// Give the init function the jQuery prototype for later instantiation (needed after Rev 4091)
$.prototype.init.prototype = $.prototype;

})(jQuery);/*
 * Metadata - jQuery plugin for parsing metadata from elements
 *
 * Copyright (c) 2006 John Resig, Yehuda Katz, J�örn Zaefferer, Paul McLanahan
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * Revision: $Id: jquery.metadata.js 3640 2007-10-11 18:34:38Z pmclanahan $
 *
 */

/**
 * Sets the type of metadata to use. Metadata is encoded in JSON, and each property
 * in the JSON will become a property of the element itself.
 *
 * There are four supported types of metadata storage:
 *
 *   attr:  Inside an attribute. The name parameter indicates *which* attribute.
 *          
 *   class: Inside the class attribute, wrapped in curly braces: { }
 *   
 *   elem:  Inside a child element (e.g. a script tag). The
 *          name parameter indicates *which* element.
 *   html5: Values are stored in data-* attributes.
 *          
 * The metadata for an element is loaded the first time the element is accessed via jQuery.
 *
 * As a result, you can define the metadata type, use $(expr) to load the metadata into the elements
 * matched by expr, then redefine the metadata type and run another $(expr) for other elements.
 * 
 * @name $.metadata.setType
 *
 * @example <p id="one" class="some_class {item_id: 1, item_label: 'Label'}">This is a p</p>
 * @before $.metadata.setType("class")
 * @after $("#one").metadata().item_id == 1; $("#one").metadata().item_label == "Label"
 * @desc Reads metadata from the class attribute
 * 
 * @example <p id="one" class="some_class" data="{item_id: 1, item_label: 'Label'}">This is a p</p>
 * @before $.metadata.setType("attr", "data")
 * @after $("#one").metadata().item_id == 1; $("#one").metadata().item_label == "Label"
 * @desc Reads metadata from a "data" attribute
 * 
 * @example <p id="one" class="some_class"><script>{item_id: 1, item_label: 'Label'}</script>This is a p</p>
 * @before $.metadata.setType("elem", "script")
 * @after $("#one").metadata().item_id == 1; $("#one").metadata().item_label == "Label"
 * @desc Reads metadata from a nested script element
 * 
 * @example <p id="one" class="some_class" data-item_id="1" data-item_label="Label">This is a p</p>
 * @before $.metadata.setType("html5")
 * @after $("#one").metadata().item_id == 1; $("#one").metadata().item_label == "Label"
 * @desc Reads metadata from a series of data-* attributes
 *
 * @param String type The encoding type
 * @param String name The name of the attribute to be used to get metadata (optional)
 * @cat Plugins/Metadata
 * @descr Sets the type of encoding to be used when loading metadata for the first time
 * @type undefined
 * @see metadata()
 */

(function($) {

$.extend({
  metadata : {
    defaults : {
      type: 'class',
      name: 'metadata',
      cre: /({.*})/,
      single: 'metadata'
    },
    setType: function( type, name ){
      this.defaults.type = type;
      this.defaults.name = name;
    },
    get: function( elem, opts ){
      var settings = $.extend({},this.defaults,opts);
      // check for empty string in single property
      if ( !settings.single.length ) settings.single = 'metadata';
      
      var data = $.data(elem, settings.single);
      // returned cached data if it already exists
      if ( data ) return data;
      
      data = "{}";
      
      var getData = function(data) {
        if(typeof data != "string") return data;
        
        if( data.indexOf('{') < 0 ) {
          data = eval("(" + data + ")");
        }
      }
      
      var getObject = function(data) {
        if(typeof data != "string") return data;
        
        data = eval("(" + data + ")");
        return data;
      }
      
      if ( settings.type == "html5" ) {
        var object = {};
        $( elem.attributes ).each(function() {
          var name = this.nodeName;
          if(name.match(/^data-/)) name = name.replace(/^data-/, '');
          else return true;
          object[name] = getObject(this.nodeValue);
        });
      } else {
        if ( settings.type == "class" ) {
          var m = settings.cre.exec( elem.className );
          if ( m )
            data = m[1];
        } else if ( settings.type == "elem" ) {
          if( !elem.getElementsByTagName ) return;
          var e = elem.getElementsByTagName(settings.name);
          if ( e.length )
            data = $.trim(e[0].innerHTML);
        } else if ( elem.getAttribute != undefined ) {
          var attr = elem.getAttribute( settings.name );
          if ( attr )
            data = attr;
        }
        object = getObject(data.indexOf("{") < 0 ? "{" + data + "}" : data);
      }
      
      $.data( elem, settings.single, object );
      return object;
    }
  }
});

/**
 * Returns the metadata object for the first member of the jQuery object.
 *
 * @name metadata
 * @descr Returns element's metadata object
 * @param Object opts An object contianing settings to override the defaults
 * @type jQuery
 * @cat Plugins/Metadata
 */
$.fn.metadata = function( opts ){
  return $.metadata.get( this[0], opts );
};

})(jQuery);//Licensed under The MIT License
//Copyright (c) 2008 Jason Frame (jason@onehackoranother.com)


(function($) {
    $.fn.tipsy = function(opts) {

        opts = $.extend({fade: false, gravity: 'n'}, opts || {});
        // ...Added by andy@twitter.com 20090717
        if(!opts['offsetTop']) { opts['offsetTop'] = 0; }
        if(!opts['offsetLeft']) { opts['offsetLeft'] = 0; }
        if(!opts['header']) { opts['header'] = ''; }
        if(!opts['footer']) { opts['footer'] = ''; }
        if(!opts['hideTimeout']) { opts['hideTimeout'] = 100; }
        if(!opts['showTimeout']) { opts['hideTimeout'] = 0; }
        if(!opts['additionalCSSClass']) { opts['additionalCSSClass'] = ''; }
        var showTimeoutKey = false;
        // ...Added by andy@twitter.com 20090717
        var tip = null, cancelHide = false;
        this.hover(function() {

            // ...Added by andy@twitter.com 20090717
            var linkText = $(this).text();
            var header = opts['header'].replace('%{link}', linkText);
            var footer = opts['footer'].replace('%{link}', linkText);
            // ...Added by andy@twitter.com 20090717

            $.data(this, 'cancel.tipsy', true);

            var tip = $.data(this, 'active.tipsy');
            if (!tip) {
                $('.tipsy').hide();
                tip = $('<div class="tipsy '+ opts['additionalCSSClass'] +'"><div class="tipsy-inner">' + header + $(this).attr('title') + footer + '</div></div>');
                tip.css({position: 'absolute', zIndex: 100000});
                $(this).attr('title', '');
                $.data(this, 'active.tipsy', tip);
            // Added by rael@twitter.com 20090628...
            } else if ($(this).attr('title') != '') {
              tip.find('.tipsy-inner').html($(this).attr('title'));
              $(this).attr('title', '');
            // ...Added by rael@twitter.com 20090628
            }

            var pos = $.extend({}, $(this).offset(), {width: this.offsetWidth, height: this.offsetHeight});
            // ...Added by andy@twitter.com 20090717
            pos.top = pos.top + opts['offsetTop'];
            pos.left = pos.left + opts['offsetLeft'];

            // remove open tips if timeout to fade
            $('.tipsy').hide();
            // ...Added by andy@twitter.com 20090717
            tip.remove().css({top: 0, left: 0, visibility: 'hidden', display: 'block'}).appendTo(document.body);
            var actualWidth = tip[0].offsetWidth, actualHeight = tip[0].offsetHeight;

            switch (opts.gravity.charAt(0)) {
                case 'n':
                    tip.css({top: pos.top + pos.height, left: pos.left + pos.width / 2 - actualWidth / 2}).addClass('tipsy-north');
                    break;
                case 'l':
                    //left north align
                    tip.css({top: pos.top + pos.height, left: pos.left + pos.width / 2 - 18}).addClass('tipsy-north');
                    break;
                case 's':
                    tip.css({top: pos.top - actualHeight, left: pos.left + pos.width / 2 - actualWidth / 2}).addClass('tipsy-south');
                    break;
                case 'e':
                    tip.css({top: pos.top + pos.height / 2 - actualHeight / 2, left: pos.left - actualWidth}).addClass('tipsy-east');
                    break;
                case 'w':
                    tip.css({top: pos.top + pos.height / 2 - actualHeight / 2, left: pos.left + pos.width}).addClass('tipsy-west');
                    break;
            }
            // ...Added by andy@twitter.com 20090717
            function show() {
              if (opts.fade) {
                  tip.css({opacity: 0, display: 'block', visibility: 'visible'}).animate({opacity: 1});
              } else {
                  tip.css({visibility: 'visible'});
              }
            }
            if(opts['showTimeout']) {
              showTimeoutKey = setTimeout(show, opts['showTimeout']);
            } else {
              show();
            }
        }, function() {
            clearTimeout(showTimeoutKey);
            // ...Added by andy@twitter.com 20090717
            $.data(this, 'cancel.tipsy', false);
            var self = this;
            setTimeout(function() {
                if ($.data(this, 'cancel.tipsy')) return;
                var tip = $.data(self, 'active.tipsy');
                if (opts.fade) {
                    tip.stop().fadeOut(function() { $(this).remove(); });
                } else {
                    tip.remove();
                }
            }, opts['hideTimeout']);
        });

    };
})(jQuery);
