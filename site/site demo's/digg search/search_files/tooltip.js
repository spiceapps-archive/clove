var config=new Object();var tt_Debug=true;var tt_Enabled=true;var TagsToTip=true;config.Above=false;config.BgColor="#fff";
config.BgImg="";config.BorderColor="#003099";config.BorderStyle="solid";config.BorderWidth=0;config.CenterMouse=false;
config.ClickClose=true;config.ClickSticky=false;config.CloseBtn=false;config.CloseBtnColors=["#990000","#FFFFFF","#DD3333","#FFFFFF"];
config.CloseBtnText="&nbsp;X&nbsp;";config.CopyContent=true;config.Delay=400;config.Duration=0;config.Exclusive=false;
config.FadeIn=100;config.FadeOut=100;config.FadeInterval=30;config.Fix=null;config.FollowMouse=true;config.FontColor="#000044";
config.FontFace="Verdana,Geneva,sans-serif";config.FontSize="8pt";config.FontWeight="normal";config.Height=0;
config.JumpHorz=false;config.JumpVert=true;config.Left=false;config.OffsetX=14;config.OffsetY=8;config.Opacity=100;
config.Padding=3;config.Shadow=false;config.ShadowColor="#C0C0C0";config.ShadowWidth=5;config.Sticky=false;
config.TextAlign="left";config.Title="";config.TitleAlign="left";config.TitleBgColor="";config.TitleFontColor="#FFFFFF";
config.TitleFontFace="";config.TitleFontSize="";config.TitlePadding=2;config.Width=0;function Tip(){tt_Tip(arguments,null)
}function TagToTip(){var A=tt_GetElt(arguments[0]);if(A){tt_Tip(arguments,A)}}function UnTip(){tt_OpReHref();
if(tt_aV[DURATION]<0&&(tt_iState&2)){tt_tDurt.Timer("tt_HideInit()",-tt_aV[DURATION],true)}else{if(!(tt_aV[STICKY]&&(tt_iState&2))){tt_HideInit()
}}}var tt_aElt=new Array(10),tt_aV=new Array(),tt_sContent,tt_t2t,tt_t2tDad,tt_musX,tt_musY,tt_over,tt_x,tt_y,tt_w,tt_h;
function tt_Extension(){tt_ExtCmdEnum();tt_aExt[tt_aExt.length]=this;return this}function tt_SetTipPos(B,D){var C=tt_aElt[0].style;
tt_x=B;tt_y=D;C.left=B+"px";C.top=D+"px";if(tt_ie56){var A=tt_aElt[tt_aElt.length-1];if(A){A.style.left=C.left;
A.style.top=C.top}}}function tt_HideInit(){if(tt_iState){tt_ExtCallFncs(0,"HideInit");tt_iState&=~(4|8);
if(tt_flagOpa&&tt_aV[FADEOUT]){tt_tFade.EndTimer();if(tt_opa){var A=Math.round(tt_aV[FADEOUT]/(tt_aV[FADEINTERVAL]*(tt_aV[OPACITY]/tt_opa)));
tt_Fade(tt_opa,tt_opa,0,A);return }}tt_tHide.Timer("tt_Hide();",1,false)}}function tt_Hide(){if(tt_db&&tt_iState){tt_OpReHref();
if(tt_iState&2){tt_aElt[0].style.visibility="hidden";tt_ExtCallFncs(0,"Hide")}tt_tShow.EndTimer();tt_tHide.EndTimer();
tt_tDurt.EndTimer();tt_tFade.EndTimer();if(!tt_op&&!tt_ie){tt_tWaitMov.EndTimer();tt_bWait=false}if(tt_aV[CLICKCLOSE]||tt_aV[CLICKSTICKY]){tt_RemEvtFnc(document,"mouseup",tt_OnLClick)
}tt_ExtCallFncs(0,"Kill");if(tt_t2t&&!tt_aV[COPYCONTENT]){tt_UnEl2Tip()}tt_iState=0;tt_over=null;tt_ResetMainDiv();
if(tt_aElt[tt_aElt.length-1]){tt_aElt[tt_aElt.length-1].style.display="none"}}}function tt_GetElt(A){return(document.getElementById?document.getElementById(A):document.all?document.all[A]:null)
}function tt_GetDivW(A){return(A?(A.offsetWidth||A.style.pixelWidth||0):0)}function tt_GetDivH(A){return(A?(A.offsetHeight||A.style.pixelHeight||0):0)
}function tt_GetScrollX(){return(window.pageXOffset||(tt_db?(tt_db.scrollLeft||0):0))}function tt_GetScrollY(){return(window.pageYOffset||(tt_db?(tt_db.scrollTop||0):0))
}function tt_GetClientW(){return tt_GetWndCliSiz("Width")}function tt_GetClientH(){return tt_GetWndCliSiz("Height")
}function tt_GetEvtX(A){return(A?((typeof (A.pageX)!=tt_u)?A.pageX:(A.clientX+tt_GetScrollX())):0)}function tt_GetEvtY(A){return(A?((typeof (A.pageY)!=tt_u)?A.pageY:(A.clientY+tt_GetScrollY())):0)
}function tt_AddEvtFnc(B,A,C){if(B){if(B.addEventListener){B.addEventListener(A,C,false)}else{B.attachEvent("on"+A,C)
}}}function tt_RemEvtFnc(B,A,C){if(B){if(B.removeEventListener){B.removeEventListener(A,C,false)}else{B.detachEvent("on"+A,C)
}}}function tt_GetDad(A){return(A.parentNode||A.parentElement||A.offsetParent)}function tt_MovDomNode(B,A,C){if(A){A.removeChild(B)
}if(C){C.appendChild(B)}}var tt_aExt=new Array(),tt_db,tt_op,tt_ie,tt_ie56,tt_bBoxOld,tt_body,tt_ovr_,tt_flagOpa,tt_maxPosX,tt_maxPosY,tt_iState=0,tt_opa,tt_bJmpVert,tt_bJmpHorz,tt_elDeHref,tt_tShow=new Number(0),tt_tHide=new Number(0),tt_tDurt=new Number(0),tt_tFade=new Number(0),tt_tWaitMov=new Number(0),tt_bWait=false,tt_u="undefined";
function tt_Init(){tt_MkCmdEnum();if(!tt_Browser()||!tt_MkMainDiv()){return }tt_IsW3cBox();tt_OpaSupport();
tt_AddEvtFnc(document,"mousemove",tt_Move);if(TagsToTip||tt_Debug){tt_SetOnloadFnc()}tt_AddEvtFnc(window,"unload",tt_Hide)
}function tt_MkCmdEnum(){var n=0;for(var i in config){eval("window."+i.toString().toUpperCase()+" = "+n++)
}tt_aV.length=n}function tt_Browser(){var n,nv,n6,w3c;n=navigator.userAgent.toLowerCase(),nv=navigator.appVersion;
tt_op=(document.defaultView&&typeof (eval("window.opera"))!=tt_u);tt_ie=n.indexOf("msie")!=-1&&document.all&&!tt_op;
if(tt_ie){var ieOld=(!document.compatMode||document.compatMode=="BackCompat");tt_db=!ieOld?document.documentElement:(document.body||null);
if(tt_db){tt_ie56=parseFloat(nv.substring(nv.indexOf("MSIE")+5))>=5.5&&typeof document.body.style.maxHeight==tt_u
}}else{tt_db=document.documentElement||document.body||(document.getElementsByTagName?document.getElementsByTagName("body")[0]:null);
if(!tt_op){n6=document.defaultView&&typeof document.defaultView.getComputedStyle!=tt_u;w3c=!n6&&document.getElementById
}}tt_body=(document.getElementsByTagName?document.getElementsByTagName("body")[0]:(document.body||null));
if(tt_ie||n6||tt_op||w3c){if(tt_body&&tt_db){if(document.attachEvent||document.addEventListener){return true
}}else{tt_Err("wz_tooltip.js must be included INSIDE the body section, immediately after the opening <body> tag.",false)
}}tt_db=null;return false}function tt_MkMainDiv(){if(tt_body.insertAdjacentHTML){tt_body.insertAdjacentHTML("afterBegin",tt_MkMainDivHtm())
}else{if(typeof tt_body.innerHTML!=tt_u&&document.createElement&&tt_body.appendChild){tt_body.appendChild(tt_MkMainDivDom())
}}if(window.tt_GetMainDivRefs&&tt_GetMainDivRefs()){return true}tt_db=null;return false}function tt_MkMainDivHtm(){return('<div id="WzTtDiV"></div>'+(tt_ie56?('<iframe id="WzTtIfRm" src="javascript:false" scrolling="no" frameborder="0" style="filter:Alpha(opacity=0);position:absolute;top:0px;left:0px;display:none;"></iframe>'):""))
}function tt_MkMainDivDom(){var A=document.createElement("div");if(A){A.id="WzTtDiV"}return A}function tt_GetMainDivRefs(){tt_aElt[0]=tt_GetElt("WzTtDiV");
if(tt_ie56&&tt_aElt[0]){tt_aElt[tt_aElt.length-1]=tt_GetElt("WzTtIfRm");if(!tt_aElt[tt_aElt.length-1]){tt_aElt[0]=null
}}if(tt_aElt[0]){var A=tt_aElt[0].style;A.visibility="hidden";A.position="absolute";A.overflow="hidden";
return true}return false}function tt_ResetMainDiv(){tt_SetTipPos(0,0);tt_aElt[0].innerHTML="";tt_aElt[0].style.width="0px";
tt_h=0}function tt_IsW3cBox(){var A=tt_aElt[0].style;A.padding="10px";A.width="40px";tt_bBoxOld=(tt_GetDivW(tt_aElt[0])==40);
A.padding="0px";tt_ResetMainDiv()}function tt_OpaSupport(){var A=tt_body.style;tt_flagOpa=(typeof (A.KhtmlOpacity)!=tt_u)?2:(typeof (A.KHTMLOpacity)!=tt_u)?3:(typeof (A.MozOpacity)!=tt_u)?4:(typeof (A.opacity)!=tt_u)?5:(typeof (A.filter)!=tt_u)?1:0
}function tt_SetOnloadFnc(){tt_AddEvtFnc(document,"DOMContentLoaded",tt_HideSrcTags);tt_AddEvtFnc(window,"load",tt_HideSrcTags);
if(tt_body.attachEvent){tt_body.attachEvent("onreadystatechange",function(){if(tt_body.readyState=="complete"){tt_HideSrcTags()
}})}if(/WebKit|KHTML/i.test(navigator.userAgent)){var A=setInterval(function(){if(/loaded|complete/.test(document.readyState)){clearInterval(A);
tt_HideSrcTags()}},10)}}function tt_HideSrcTags(){if(!window.tt_HideSrcTags||window.tt_HideSrcTags.done){return 
}window.tt_HideSrcTags.done=true;if(!tt_HideSrcTagsRecurs(tt_body)){tt_Err("There are HTML elements to be converted to tooltips.\nIf you want these HTML elements to be automatically hidden, you must edit wz_tooltip.js, and set TagsToTip in the global tooltip configuration to true.",true)
}}function tt_HideSrcTagsRecurs(B){var E,D;var A=B.childNodes||B.children||null;for(var C=A?A.length:0;
C;){--C;if(!tt_HideSrcTagsRecurs(A[C])){return false}E=A[C].getAttribute?(A[C].getAttribute("onmouseover")||A[C].getAttribute("onclick")):(typeof A[C].onmouseover=="function")?(A[C].onmouseover||A[C].onclick):null;
if(E){D=E.toString().match(/TagToTip\s*\(\s*'[^'.]+'\s*[\),]/);if(D&&D.length){if(!tt_HideSrcTag(D[0])){return false
}}}}return true}function tt_HideSrcTag(B){var C,A;C=B.replace(/.+'([^'.]+)'.+/,"$1");A=tt_GetElt(C);if(A){if(tt_Debug&&!TagsToTip){return false
}else{A.style.display="none"}}else{tt_Err("Invalid ID\n'"+C+"'\npassed to TagToTip(). There exists no HTML element with that ID.",true)
}return true}function tt_Tip(A,B){if(!tt_db||(tt_iState&8)){return }if(tt_iState){tt_Hide()}if(!tt_Enabled){return 
}tt_t2t=B;if(!tt_ReadCmds(A)){return }tt_iState=1|4;tt_AdaptConfig1();tt_MkTipContent(A);tt_MkTipSubDivs();
tt_FormatTip();tt_bJmpVert=false;tt_bJmpHorz=false;tt_maxPosX=tt_GetClientW()+tt_GetScrollX()-tt_w-1;
tt_maxPosY=tt_GetClientH()+tt_GetScrollY()-tt_h-1;tt_AdaptConfig2();tt_OverInit();tt_ShowInit();tt_Move()
}function tt_ReadCmds(A){var C;C=0;for(var B in config){tt_aV[C++]=config[B]}if(A.length&1){for(C=A.length-1;
C>0;C-=2){tt_aV[A[C-1]]=A[C]}return true}tt_Err("Incorrect call of Tip() or TagToTip().\nEach command must be followed by a value.",true);
return false}function tt_AdaptConfig1(){tt_ExtCallFncs(0,"LoadConfig");if(!tt_aV[TITLEBGCOLOR].length){tt_aV[TITLEBGCOLOR]=tt_aV[BORDERCOLOR]
}if(!tt_aV[TITLEFONTCOLOR].length){tt_aV[TITLEFONTCOLOR]=tt_aV[BGCOLOR]}if(!tt_aV[TITLEFONTFACE].length){tt_aV[TITLEFONTFACE]=tt_aV[FONTFACE]
}if(!tt_aV[TITLEFONTSIZE].length){tt_aV[TITLEFONTSIZE]=tt_aV[FONTSIZE]}if(tt_aV[CLOSEBTN]){if(!tt_aV[CLOSEBTNCOLORS]){tt_aV[CLOSEBTNCOLORS]=new Array("","","","")
}for(var A=4;A;){--A;if(!tt_aV[CLOSEBTNCOLORS][A].length){tt_aV[CLOSEBTNCOLORS][A]=(A&1)?tt_aV[TITLEFONTCOLOR]:tt_aV[TITLEBGCOLOR]
}}if(!tt_aV[TITLE].length){tt_aV[TITLE]=" "}}if(tt_aV[OPACITY]==100&&typeof tt_aElt[0].style.MozOpacity!=tt_u&&!Array.every){tt_aV[OPACITY]=99
}if(tt_aV[FADEIN]&&tt_flagOpa&&tt_aV[DELAY]>100){tt_aV[DELAY]=Math.max(tt_aV[DELAY]-tt_aV[FADEIN],100)
}}function tt_AdaptConfig2(){if(tt_aV[CENTERMOUSE]){tt_aV[OFFSETX]-=((tt_w-(tt_aV[SHADOW]?tt_aV[SHADOWWIDTH]:0))>>1);
tt_aV[JUMPHORZ]=false}}function tt_MkTipContent(A){if(tt_t2t){if(tt_aV[COPYCONTENT]){tt_sContent=tt_t2t.innerHTML
}else{tt_sContent=""}}else{tt_sContent=A[0]}tt_ExtCallFncs(0,"CreateContentString")}function tt_MkTipSubDivs(){var B="position:relative;margin:0px;padding:0px;border-width:0px;left:0px;top:0px;line-height:normal;width:auto;",A=' cellspacing="0" cellpadding="0" border="0" style="'+B+'"><tbody style="'+B+'"><tr><td ';
tt_aElt[0].style.width=tt_GetClientW()+"px";tt_aElt[0].innerHTML=(""+(tt_aV[TITLE].length?('<div id="WzTiTl" style="position:relative;z-index:1;"><table id="WzTiTlTb"'+A+'id="WzTiTlI" style="'+B+'">'+tt_aV[TITLE]+"</td>"+(tt_aV[CLOSEBTN]?('<td align="right" style="'+B+'text-align:right;"><span id="WzClOsE" style="position:relative;left:2px;padding-left:2px;padding-right:2px;cursor:'+(tt_ie?"hand":"pointer")+';" onmouseover="tt_OnCloseBtnOver(1)" onmouseout="tt_OnCloseBtnOver(0)" onclick="tt_HideInit()">'+tt_aV[CLOSEBTNTEXT]+"</span></td>"):"")+"</tr></tbody></table></div>"):"")+'<div id="WzBoDy" style="position:relative;z-index:0;"><table'+A+'id="WzBoDyI" style="'+B+'">'+tt_sContent+"</td></tr></tbody></table></div>"+(tt_aV[SHADOW]?('<div id="WzTtShDwR" style="position:absolute;overflow:hidden;"></div><div id="WzTtShDwB" style="position:relative;overflow:hidden;"></div>'):""));
tt_GetSubDivRefs();if(tt_t2t&&!tt_aV[COPYCONTENT]){tt_El2Tip()}tt_ExtCallFncs(0,"SubDivsCreated")}function tt_GetSubDivRefs(){var B=new Array("WzTiTl","WzTiTlTb","WzTiTlI","WzClOsE","WzBoDy","WzBoDyI","WzTtShDwB","WzTtShDwR");
for(var A=B.length;A;--A){tt_aElt[A]=tt_GetElt(B[A-1])}}function tt_FormatTip(){var F,I,E,B=tt_aV[PADDING],D,C=tt_aV[BORDERWIDTH],A,G,H=(B+C)<<1;
if(tt_aV[TITLE].length){D=tt_aV[TITLEPADDING];F=tt_aElt[1].style;F.background=tt_aV[TITLEBGCOLOR];F.paddingTop=F.paddingBottom=D+"px";
F.paddingLeft=F.paddingRight=(D+2)+"px";F=tt_aElt[3].style;F.color=tt_aV[TITLEFONTCOLOR];if(tt_aV[WIDTH]==-1){F.whiteSpace="nowrap"
}F.fontFamily=tt_aV[TITLEFONTFACE];F.fontSize=tt_aV[TITLEFONTSIZE];F.fontWeight="bold";F.textAlign=tt_aV[TITLEALIGN];
if(tt_aElt[4]){F=tt_aElt[4].style;F.background=tt_aV[CLOSEBTNCOLORS][0];F.color=tt_aV[CLOSEBTNCOLORS][1];
F.fontFamily=tt_aV[TITLEFONTFACE];F.fontSize=tt_aV[TITLEFONTSIZE];F.fontWeight="bold"}if(tt_aV[WIDTH]>0){tt_w=tt_aV[WIDTH]
}else{tt_w=tt_GetDivW(tt_aElt[3])+tt_GetDivW(tt_aElt[4]);if(tt_aElt[4]){tt_w+=B}if(tt_aV[WIDTH]<-1&&tt_w>-tt_aV[WIDTH]){tt_w=-tt_aV[WIDTH]
}}A=-C}else{tt_w=0;A=0}F=tt_aElt[5].style;F.top=A+"px";if(C){F.borderColor=tt_aV[BORDERCOLOR];F.borderStyle=tt_aV[BORDERSTYLE];
F.borderWidth=C+"px"}if(tt_aV[BGCOLOR].length){F.background=tt_aV[BGCOLOR]}if(tt_aV[BGIMG].length){F.backgroundImage="url("+tt_aV[BGIMG]+")"
}F.padding=B+"px";F.textAlign=tt_aV[TEXTALIGN];if(tt_aV[HEIGHT]){F.overflow="auto";if(tt_aV[HEIGHT]>0){F.height=(tt_aV[HEIGHT]+H)+"px"
}else{tt_h=H-tt_aV[HEIGHT]}}F=tt_aElt[6].style;F.color=tt_aV[FONTCOLOR];F.fontFamily=tt_aV[FONTFACE];
F.fontSize=tt_aV[FONTSIZE];F.fontWeight=tt_aV[FONTWEIGHT];F.textAlign=tt_aV[TEXTALIGN];if(tt_aV[WIDTH]>0){I=tt_aV[WIDTH]
}else{if(tt_aV[WIDTH]==-1&&tt_w){I=tt_w}else{I=tt_GetDivW(tt_aElt[6]);if(tt_aV[WIDTH]<-1&&I>-tt_aV[WIDTH]){I=-tt_aV[WIDTH]
}}}if(I>tt_w){tt_w=I}tt_w+=H;if(tt_aV[SHADOW]){tt_w+=tt_aV[SHADOWWIDTH];G=Math.floor((tt_aV[SHADOWWIDTH]*4)/3);
F=tt_aElt[7].style;F.top=A+"px";F.left=G+"px";F.width=(tt_w-G-tt_aV[SHADOWWIDTH])+"px";F.height=tt_aV[SHADOWWIDTH]+"px";
F.background=tt_aV[SHADOWCOLOR];F=tt_aElt[8].style;F.top=G+"px";F.left=(tt_w-tt_aV[SHADOWWIDTH])+"px";
F.width=tt_aV[SHADOWWIDTH]+"px";F.background=tt_aV[SHADOWCOLOR]}else{G=0}tt_SetTipOpa(tt_aV[FADEIN]?0:tt_aV[OPACITY]);
tt_FixSize(A,G)}function tt_FixSize(A,G){var H,D,F,I,B=tt_aV[PADDING],C=tt_aV[BORDERWIDTH],E;tt_aElt[0].style.width=tt_w+"px";
tt_aElt[0].style.pixelWidth=tt_w;D=tt_w-((tt_aV[SHADOW])?tt_aV[SHADOWWIDTH]:0);H=D;if(!tt_bBoxOld){H-=(B+C)<<1
}tt_aElt[5].style.width=H+"px";if(tt_aElt[1]){H=D-((tt_aV[TITLEPADDING]+2)<<1);if(!tt_bBoxOld){D=H}tt_aElt[1].style.width=D+"px";
tt_aElt[2].style.width=H+"px"}if(tt_h){F=tt_GetDivH(tt_aElt[5]);if(F>tt_h){if(!tt_bBoxOld){tt_h-=(B+C)<<1
}tt_aElt[5].style.height=tt_h+"px"}}tt_h=tt_GetDivH(tt_aElt[0])+A;if(tt_aElt[8]){tt_aElt[8].style.height=(tt_h-G)+"px"
}E=tt_aElt.length-1;if(tt_aElt[E]){tt_aElt[E].style.width=tt_w+"px";tt_aElt[E].style.height=tt_h+"px"
}}function tt_DeAlt(C){var A;if(C){if(C.alt){C.alt=""}if(C.title){C.title=""}A=C.childNodes||C.children||null;
if(A){for(var B=A.length;B;){tt_DeAlt(A[--B])}}}}function tt_OpDeHref(A){if(!tt_op){return }if(tt_elDeHref){tt_OpReHref()
}while(A){if(A.hasAttribute&&A.hasAttribute("href")){A.t_href=A.getAttribute("href");A.t_stats=window.status;
A.removeAttribute("href");A.style.cursor="hand";tt_AddEvtFnc(A,"mousedown",tt_OpReHref);window.status=A.t_href;
tt_elDeHref=A;break}A=tt_GetDad(A)}}function tt_OpReHref(){if(tt_elDeHref){tt_elDeHref.setAttribute("href",tt_elDeHref.t_href);
tt_RemEvtFnc(tt_elDeHref,"mousedown",tt_OpReHref);window.status=tt_elDeHref.t_stats;tt_elDeHref=null}}function tt_El2Tip(){var A=tt_t2t.style;
tt_t2t.t_cp=A.position;tt_t2t.t_cl=A.left;tt_t2t.t_ct=A.top;tt_t2t.t_cd=A.display;tt_t2tDad=tt_GetDad(tt_t2t);
tt_MovDomNode(tt_t2t,tt_t2tDad,tt_aElt[6]);A.display="block";A.position="static";A.left=A.top=A.marginLeft=A.marginTop="0px"
}function tt_UnEl2Tip(){var A=tt_t2t.style;A.display=tt_t2t.t_cd;tt_MovDomNode(tt_t2t,tt_GetDad(tt_t2t),tt_t2tDad);
A.position=tt_t2t.t_cp;A.left=tt_t2t.t_cl;A.top=tt_t2t.t_ct;tt_t2tDad=null}function tt_OverInit(){if(window.event){tt_over=window.event.target||window.event.srcElement
}else{tt_over=tt_ovr_}tt_DeAlt(tt_over);tt_OpDeHref(tt_over)}function tt_ShowInit(){tt_tShow.Timer("tt_Show()",tt_aV[DELAY],true);
if(tt_aV[CLICKCLOSE]||tt_aV[CLICKSTICKY]){tt_AddEvtFnc(document,"mouseup",tt_OnLClick)}}function tt_Show(){var A=tt_aElt[0].style;
A.zIndex=Math.max((window.dd&&dd.z)?(dd.z+2):0,1010);if(tt_aV[STICKY]||!tt_aV[FOLLOWMOUSE]){tt_iState&=~4
}if(tt_aV[EXCLUSIVE]){tt_iState|=8}if(tt_aV[DURATION]>0){tt_tDurt.Timer("tt_HideInit()",tt_aV[DURATION],true)
}tt_ExtCallFncs(0,"Show");A.visibility="visible";tt_iState|=2;if(tt_aV[FADEIN]){tt_Fade(0,0,tt_aV[OPACITY],Math.round(tt_aV[FADEIN]/tt_aV[FADEINTERVAL]))
}tt_ShowIfrm()}function tt_ShowIfrm(){if(tt_ie56){var A=tt_aElt[tt_aElt.length-1];if(A){var B=A.style;
B.zIndex=tt_aElt[0].style.zIndex-1;B.display="block"}}}function tt_Move(A){if(A){tt_ovr_=A.target||A.srcElement
}A=A||window.event;if(A){tt_musX=tt_GetEvtX(A);tt_musY=tt_GetEvtY(A)}if(tt_iState&4){if(!tt_op&&!tt_ie){if(tt_bWait){return 
}tt_bWait=true;tt_tWaitMov.Timer("tt_bWait = false;",1,true)}if(tt_aV[FIX]){tt_iState&=~4;tt_PosFix()
}else{if(!tt_ExtCallFncs(A,"MoveBefore")){tt_SetTipPos(tt_Pos(0),tt_Pos(1))}}tt_ExtCallFncs([tt_musX,tt_musY],"MoveAfter")
}}function tt_Pos(B){var H,J,C,A,D,F,E,G,I;if(B){J=tt_aV[JUMPVERT];C=ABOVE;A=OFFSETY;D=tt_h;F=tt_maxPosY;
E=tt_GetScrollY();G=tt_musY;I=tt_bJmpVert}else{J=tt_aV[JUMPHORZ];C=LEFT;A=OFFSETX;D=tt_w;F=tt_maxPosX;
E=tt_GetScrollX();G=tt_musX;I=tt_bJmpHorz}if(J){if(tt_aV[C]&&(!I||tt_CalcPosAlt(B)>=E+16)){H=tt_PosAlt(B)
}else{if(!tt_aV[C]&&I&&tt_CalcPosDef(B)>F-16){H=tt_PosAlt(B)}else{H=tt_PosDef(B)}}}else{H=G;if(tt_aV[C]){H-=D+tt_aV[A]-(tt_aV[SHADOW]?tt_aV[SHADOWWIDTH]:0)
}else{H+=tt_aV[A]}}if(H>F){H=J?tt_PosAlt(B):F}if(H<E){H=J?tt_PosDef(B):E}return H}function tt_PosDef(A){if(A){tt_bJmpVert=tt_aV[ABOVE]
}else{tt_bJmpHorz=tt_aV[LEFT]}return tt_CalcPosDef(A)}function tt_PosAlt(A){if(A){tt_bJmpVert=!tt_aV[ABOVE]
}else{tt_bJmpHorz=!tt_aV[LEFT]}return tt_CalcPosAlt(A)}function tt_CalcPosDef(A){return A?(tt_musY+tt_aV[OFFSETY]):(tt_musX+tt_aV[OFFSETX])
}function tt_CalcPosAlt(B){var C=B?OFFSETY:OFFSETX;var A=tt_aV[C]-(tt_aV[SHADOW]?tt_aV[SHADOWWIDTH]:0);
if(tt_aV[C]>0&&A<=0){A=1}return((B?(tt_musY-tt_h):(tt_musX-tt_w))-A)}function tt_PosFix(){var A,B;if(typeof (tt_aV[FIX][0])=="number"){A=tt_aV[FIX][0];
B=tt_aV[FIX][1]}else{if(typeof (tt_aV[FIX][0])=="string"){el=tt_GetElt(tt_aV[FIX][0])}else{el=tt_aV[FIX][0]
}A=tt_aV[FIX][1];B=tt_aV[FIX][2];if(!tt_aV[ABOVE]&&el){B+=tt_GetDivH(el)}for(;el;el=el.offsetParent){A+=el.offsetLeft||0;
B+=el.offsetTop||0}}if(tt_aV[ABOVE]){B-=tt_h}tt_SetTipPos(A,B)}function tt_Fade(A,B,C,D){if(D){B+=Math.round((C-B)/D);
if((C>A)?(B>=C):(B<=C)){B=C}else{tt_tFade.Timer("tt_Fade("+A+","+B+","+C+","+(D-1)+")",tt_aV[FADEINTERVAL],true)
}}B?tt_SetTipOpa(B):tt_Hide()}function tt_SetTipOpa(A){tt_SetOpa(tt_aElt[5],A);if(tt_aElt[1]){tt_SetOpa(tt_aElt[1],A)
}if(tt_aV[SHADOW]){A=Math.round(A*0.8);tt_SetOpa(tt_aElt[7],A);tt_SetOpa(tt_aElt[8],A)}}function tt_OnCloseBtnOver(B){var A=tt_aElt[4].style;
B<<=1;A.background=tt_aV[CLOSEBTNCOLORS][B];A.color=tt_aV[CLOSEBTNCOLORS][B+1]}function tt_OnLClick(A){A=A||window.event;
if(!((A.button&&A.button&2)||(A.which&&A.which==3))){if(tt_aV[CLICKSTICKY]&&(tt_iState&4)){tt_aV[STICKY]=true;
tt_iState&=~4}else{if(tt_aV[CLICKCLOSE]){tt_HideInit()}}}}function tt_Int(A){var B;return(isNaN(B=parseInt(A))?0:B)
}Number.prototype.Timer=function(C,B,A){if(!this.value||A){this.value=window.setTimeout(C,B)}};Number.prototype.EndTimer=function(){if(this.value){window.clearTimeout(this.value);
this.value=0}};function tt_GetWndCliSiz(C){var A,F=window["inner"+C],E="client"+C,D="number";if(typeof F==D){var B;
return(((A=document.body)&&typeof (B=A[E])==D&&B&&B<=F)?B:((A=document.documentElement)&&typeof (B=A[E])==D&&B&&B<=F)?B:F)
}return(((A=document.documentElement)&&(F=A[E]))?F:document.body[E])}function tt_SetOpa(C,A){var B=C.style;
tt_opa=A;if(tt_flagOpa==1){if(A<100){if(typeof (C.filtNo)==tt_u){C.filtNo=B.filter}var D=B.visibility!="hidden";
B.zoom="100%";if(!D){B.visibility="visible"}B.filter="alpha(opacity="+A+")";if(!D){B.visibility="hidden"
}}else{if(typeof (C.filtNo)!=tt_u){B.filter=C.filtNo}}}else{A/=100;switch(tt_flagOpa){case 2:B.KhtmlOpacity=A;
break;case 3:B.KHTMLOpacity=A;break;case 4:B.MozOpacity=A;break;case 5:B.opacity=A;break}}}function tt_Err(B,A){if(tt_Debug||!A){alert("Tooltip Script Error Message:\n\n"+B)
}}function tt_ExtCmdEnum(){var s;for(var i in config){s="window."+i.toString().toUpperCase();if(eval("typeof("+s+") == tt_u")){eval(s+" = "+tt_aV.length);
tt_aV[tt_aV.length]=null}}}function tt_ExtCallFncs(B,C){var A=false;for(var D=tt_aExt.length;D;){--D;
var E=tt_aExt[D]["On"+C];if(E&&E(B)){A=true}}return A}tt_Init();