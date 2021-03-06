<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Smart Editor</title>
<%-- <%@ include file="/ekp/img/config.jsp" %> --%>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link href="css/smart_editor2.css" rel="stylesheet" type="text/css">
<style type="text/css">
#smart_editor2 a:hover{cursor:pointer;text-decoration:none}
#smart_editor2 .se2_text_tool li.image .layer .list_area div.graph {padding:0 0 0 0;}
.KButton{display:inline-block;position:relative;padding:0px;background-image:none;visibility:visible;}
.KButton.img{filter:alpha(enabled:false);-moz-opacity:1;-khtml-opacity:1;opacity:1;}
.KButton.img.disabled{cursor:default;filter:alpha(opacity:40,style:3,finishOpacity:100,enabled:true);-moz-opacity:0.4;-khtml-opacity:0.4;opacity:0.4;}
.KButton.btn{text-align:center;color:#565960;font-weight:bold;padding:0 11px;letter-spacing:-1px;-moz-box-sizing:border-box;box-sizing:border-box;}
.KButton.btn .btn_edge{position:absolute;left:0;top:0;width:2px;height:100%;}
.KButton.btn .btn_edge:first-child{right:0;left:auto;}
.KButton.btn .btn_content{white-space: nowrap;}
.KButton.btn .icon{padding:2px 0px 0px 19px;background-position:left 50%;background-repeat:no-repeat;}
.KButton.btn.disabled{cursor:default;filter:alpha(opacity:40,style:3,finishOpacity:100,enabled:true);-moz-opacity:0.4;-khtml-opacity:0.4;opacity:0.4;}
.KButton.btn.H24{height:24px;line-height:26px;background:url(<%= request.getContextPath() %>/img/btn/bg/btn24.gif) 0 -24px repeat-x;font-size:11px;}
.KButton.btn.H24 .btn_edge{background:url(<%= request.getContextPath() %>/img/btn/bg/btn24.gif) 0 0 no-repeat;}
.KButton.btn.H24 .btn_edge:first-child{background-position:0 -48px;}
.KButton.btn.H24.hover{background-image:url(<%= request.getContextPath() %>/img/btn/bg/btn24_hover.gif);}
.KButton.btn.H24.hover .btn_edge{background:url(<%= request.getContextPath() %>/img/btn/bg/btn24_hover.gif) 0 0 no-repeat;}
.KButton.btn.H24.hover .btn_edge:first-child{background-position:0 -48px;}
.KButton.btn.H24.active{background-image:url(<%= request.getContextPath() %>/img/btn/bg/btn24_active.gif);}
.KButton.btn.H24.active .btn_edge{background:url(<%= request.getContextPath() %>/img/btn/bg/btn24_active.gif) 0 0 no-repeat;}
.KButton.btn.H24.active .btn_edge:first-child{background-position:0 -48px;}
</style>
<%-- <script type="text/javascript" src="<%= request.getContextPath() %>/lib/com/kcube/jsv/jsv-utils.js"></script> --%>
<%-- <script type="text/javascript" src="<%= request.getContextPath() %>/sys/jsv/swfupload/swfupload.js"></script> --%>
<%-- <script type="text/javascript" src="<%= request.getContextPath() %>/sys/jsv/swfupload/plugins/swfupload.queue.js"></script> --%>

<script type="text/javascript" src="./js/lib/jindo2.all.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/lib/jindo_component.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/SE2M_Configuration.js" charset="utf-8"></script>	<!-- ?????? ?????? -->
<script type="text/javascript" src="./js/SE2BasicCreator.js" charset="utf-8"></script>

<script src='./js/smarteditor2.js' charset='utf-8'></script>
<script type="text/javascript" src="./js/SE_CustomPlugins.js?version=20170720" charset="utf-8"></script>

<script type="text/javascript">
function KButton(parent, style){
	this.style   = style ? ((typeof style == 'string') ? JSV.toJsonObj(style) : style) : {}; 
	this.parents = [];
	this.buttons = [];
	if(parent && parent instanceof Array && parent.length > 1){
		this.parents = parent;
	}else{
		this.parents.push(parent);
	}
	this.createButton();
}
KButton.prototype.createButton = function(){
	for(var i=0; i < this.parents.length; i++){
		var parent = this.parents[i];
		var btn = new this.button(parent, this.style);
		btn.component = this;
		btn.onclick = function(event) { 
			if(this.component.onclick) {
				this.component.onclick(event);
			}
		}
		this.buttons.push(btn);
	}
}
KButton.prototype.getWidget = function(idx){
	if(idx && this.buttons[idx]){
		return this.buttons[idx].widget;
	} else {
		return this.buttons[0].widget;
	}
}
KButton.prototype.hide = function(){
	jQuery(this.buttons).each(function(i){
		this.widget.hide();
	});
}
KButton.prototype.show = function(){
	jQuery(this.buttons).each(function(i){
		this.widget.show();
	});
}
KButton.prototype.visible = function(isVisible){
	jQuery(this.buttons).each(function(i){
		this.widget.get(0).style.visibility = (isVisible) ? 'visible' : 'hidden';
	});
}
KButton.prototype.setEnable = function(){
	jQuery(this.buttons).each(function(i){
		this.setEnable();
	});
}
KButton.prototype.setDisable = function(){
	jQuery(this.buttons).each(function(i){
		this.setDisable();
	});
}
KButton.prototype.attachEvent = function(name, e){
	jQuery(this.buttons).each(function(i){
		this.attachEvent(name, e);
	});
}
KButton.prototype.detachEvent = function(name){
	jQuery(this.buttons).each(function(i){
		this.detachEvent(name);
	});
}
KButton.prototype.setOrder = function(){
	var order = arguments[0];
	jQuery(this.buttons).each(function(i){
		this.setOrder(order);
	});
}
KButton.prototype.button = function(parent, style){
	this.parent = parent;
	this.style = style;
	this.className = this.style.className ? 
			(KButton.CLASS_MAPPING[this.style.className] ? KButton.CLASS_MAPPING[this.style.className]: this.style.className)
			: KButton.DEFAULT_BTN_CLASS;
	this.enable  = true;
	try {
		this.widget = jQuery('<a>').addClass(KButton.CLASS_NAME).appendTo(this.parent);
	} catch (e) {
		this.seq = JSV.SEQUENCE++;
		jQuery(this.parent).append('<a a="' + KButton.CLASS_NAME + '" id="Err' + KButton.CLASS_NAME + this.seq + '"></a>');
		this.widget = jQuery(this.parent.document.getElementById('Err' + KButton.CLASS_NAME + this.seq));
	}
	this.init();
}
KButton.prototype.button.prototype.init = function(){
	if(this.style.css){
		this.widget.css(this.style.css);
	}
	var preElement = this.widget.prev().get(0);
	if(preElement && preElement.className && preElement.className.indexOf(KButton.CLASS_NAME) > -1 && preElement.style.display != 'none') {
		this.widget.css('margin-left', '3px');
	}
	this.setData();
	this.bind();
}
KButton.prototype.button.prototype.setData = function(){
	if(this.style.icon && !this.style.text) {
		this.widget.addClass('img');
		jQuery('<img>').attr({'src':JSV.getContextPath(this.style.icon), 
			'border' : '0',
			'title' : (this.style.title || '')
		}).addClass('btn_image').appendTo(this.widget);
	} else {
		this.widget.addClass('btn').addClass(this.className || KButton.DEFAULT_BTN_CLASS).append('\
				<span class="btn_edge"></span>\
				<span class="btn_content"></span>\
				<span class="btn_edge"></span>');
		var content = this.widget.children('.btn_content');
		content.html(this.style.text).attr('title', this.style.text || '&nbsp;');
		if(this.style.icon){
			content.addClass('icon').css('background-image', 'url(' + JSV.getContextPath(this.style.icon) + ')');
		}
	}
}
KButton.prototype.button.prototype.setOrder = function(){
	var arr = arguments[0];
	if(typeof(arr) != 'object' || arr.length < 4) return;
	this.NORMAL  = arr[0];
	this.OVER 	 = arr[1];
	this.DOWN 	 = arr[2];
	this.DISABLE = arr[3];
}
KButton.prototype.button.prototype.setEnable = function(){
	if(this.enable) return;
	this.widget.removeClass('disabled');
	this.bind();
	this.enable = true;
}
KButton.prototype.button.prototype.setDisable = function(){
	if(!this.enable) return;
	this.widget.addClass('disabled');
	this.unbind();
	this.enable = false;
}
KButton.prototype.button.prototype.bind = function(){
	this.widget.bind('click.KButton', this, function(event){
		if(typeof(event.data.onclick) == 'function'){
			event.data.onclick(event);
		}
	}).bind('mousedown.KButton', function(event){
		jQuery(this).addClass('active');
	}).bind('mouseup.KButton', function(event){
		jQuery(this).removeClass('active');
	}).bind('mouseover.KButton', function(event){
		jQuery(this).addClass('hover');
	}).bind('mouseout.KButton', function(event){
		jQuery(this).removeClass('hover').removeClass('active');
	});
}
KButton.prototype.button.prototype.unbind = function(){
	this.widget.unbind('click.KButton');
	this.widget.unbind('mousedown.KButton');
	this.widget.unbind('mouseup.KButton');
	this.widget.unbind('mouseover.KButton');
	this.widget.unbind('mouseout.KButton');
}
KButton.prototype.button.prototype.attachEvent = function(name, e){
	this.widget.unbind('click.' + name).bind('click.' + name, this, function(event){
		e(event);
	});
}
KButton.prototype.button.prototype.detachEvent = function(name){
	this.widget.unbind('click.' + name);
}
KButton.CLASS_NAME = 'KButton';
KButton.DEFAULT_BTN_CLASS = 'H29';
KButton.CLASS_MAPPING = {
	'SMALL' : 'H25',
	'NORMAL' : 'H29',
	'LARGE' : 'H29',
	'H20' : 'H24',
	'H20ICON' : 'H24',
	'blue' : 'H29_blue'
}
<%-- var _CONTEXT_PATH = "<%= request.getContextPath() %>"; --%>
<%-- var _ISMOVIE = "<%=com.kcube.sys.license.LicenseService.isAuthorized(com.kcube.sys.PlusAppBoot.MODULE_MOVIE)%>"; --%>
<%-- var _IMGFILESIZE = "<%=getFileSize()%>"; --%>
// var _IMGLIMITTEXT = "<p>??? ????????? " + (_IMGFILESIZE > 0 ? ("?????? <span class='limit_text'>" + Math.ceil(_IMGFILESIZE/1024 * 10)/10 + "MB</span>??????") : "????????????") + " ?????? ??? ??????,<br/>??? ?????? ?????? ?????? ????????? ????????? ??? ????????????.</p>";
<%-- var _IMGCOUNT = "<%=getCount()%>"; --%>
// var _FILECOUNTLIMIT_MSG = "?????? ?????? ????????? ?????? ?????? ?????? ????????? ?????? ?????? ???????????????.";
// var _CLOSE_MSG = "???????????? ???????????? ?????? ?????? ??????????????????????";
// var _FILE_EXCEEDS_SIZE_LIMIT = "????????? ?????? ?????? ????????? ?????? ?????? ???????????????.";
// var _ZERO_BYTE_FILE = "0Btye ??????????????? ?????? ?????? ???????????????.";
// var _INVALID_FILETYPE =	"????????? ????????? ?????? ????????? ?????? ?????? ???????????????.";
// var _UNKNOWN = "?????? ?????? ????????? ?????? ??? ?????? ?????? ???????????????.";
// var _BTNTEXT = "????????????";
// var _LANG = 'ko_KR';
</script>
</head>
<body>
<!-- SE2 Markup Start -->	
<div id="smart_editor2">
	<div id="smart_editor2_content"><a href="#se2_iframe" class="blind">????????????????????? ????????????</a>
		<div class="se2_tool" id="se2_tool">
			
			<div class="se2_text_tool husky_seditor_text_tool">
			<ul class="se2_font_type">
				<li class="husky_seditor_ui_fontName"><button type="button" class="se2_font_family" title="??????"><span class="husky_se2m_current_fontName">??????</span></button>
					<!-- ?????? ????????? -->
					<div class="se2_layer husky_se_fontName_layer">
						<div class="se2_in_layer">
							<ul class="se2_l_font_fam">
							<!-- ????????? ????????? ????????? smarteditor2.js ??? ?????? ???????????? ???????????? ?????? ????????????. (line 11137 ~ 11148)-->
							<li style="display:none"><button type="button"><span>@DisplayName@<span>(</span><em style="font-family:FontFamily;">@SampleText@</em><span>)</span></span></button></li>
							<li><button type="button"><span>??????<span>(</span><em style="font-family:'??????',Dotum,Sans-serif;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>?????????<span>(</span><em style="font-family:'?????????',DotumChe,Sans-serif;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>??????<span>(</span><em style="font-family:'??????',Gulim,Sans-serif;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>?????????<span>(</span><em style="font-family:'?????????',GulimChe,Sans-serif;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>??????<span>(</span><em style="font-family:'??????',Batang,serif;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>?????????<span>(</span><em style="font-family:'?????????',BatangChe,serif;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>??????<span>(</span><em style="font-family:'??????',Gungsuh,serif;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>Arial<span>(</span><em style="font-family:arial,Sans-serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>Tahoma<span>(</span><em style="font-family:tahoma,Sans-serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>Times New Roman<span>(</span><em style="font-family:'Times New Roman',Times,serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>Verdana<span>(</span><em style="font-family:verdana,Sans-serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>Courier New<span>(</span><em style="font-family:Courier New,Sans-serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>????????????<span>(</span><em style="font-family:'????????????',NanumGothic;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>????????????<span>(</span><em style="font-family:'????????????',NanumMyeongjo;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>??????????????????<span>(</span><em style="font-family:'??????????????????',NanumGothicCoding;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>??????????????????<span>(</span><em style="font-family:'??????????????????',NanumBarunGothic;">????????????</em><span>)</span></span></button></li>
							<li><button type="button"><span>???????????????<span>(</span><em style="font-family:'???????????????',NanumBarunPen;">????????????</em><span>)</span></span></button></li>
							</ul>
						</div>
					</div>
					<!-- //?????? ????????? -->
				</li>

				<li class="husky_seditor_ui_fontSize"><button type="button" class="se2_font_size" title="????????????"><span class="husky_se2m_current_fontSize">??????</span></button>
					<!-- ?????? ????????? ????????? -->
					<div class="se2_layer husky_se_fontSize_layer">
						<div class="se2_in_layer">
							<ul class="se2_l_font_size">
							<li><button type="button"><span style="margin-top:4px; margin-bottom:3px; margin-left:5px; font-size:7pt;">?????????????????????<span style=" font-size:7pt;">(7pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:2px; font-size:8pt;">?????????????????????<span style="font-size:8pt;">(8pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:1px; font-size:9pt;">?????????????????????<span style="font-size:9pt;">(9pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:1px; font-size:10pt;">?????????????????????<span style="font-size:10pt;">(10pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:2px; font-size:11pt;">?????????????????????<span style="font-size:11pt;">(11pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:1px; font-size:12pt;">?????????????????????<span style="font-size:12pt;">(12pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:2px; font-size:14pt;">?????????????????????<span style="margin-left:6px;font-size:14pt;">(14pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:1px; font-size:18pt;">?????????????????????<span style="margin-left:8px;font-size:18pt;">(18pt)</span></span></button></li>
							<li><button type="button"><span style="margin-left:3px; font-size:24pt;">???????????????<span style="margin-left:11px;font-size:24pt;">(24pt)</span></span></button></li>
							<li><button type="button"><span style="margin-top:-1px; margin-left:3px; font-size:36pt;">?????????<span style="font-size:36pt;">(36pt)</span></span></button></li>
							</ul>
						</div>
					</div>
					<!-- //?????? ????????? ????????? -->
				</li>
</ul><ul>
				<li class="husky_seditor_ui_bold first_child"><button type="button" title="??????[Ctrl+B]" class="se2_bold"><span class="_buttonRound tool_bg">??????[Ctrl+B]</span></button></li>

				<li class="husky_seditor_ui_underline"><button type="button" title="??????[Ctrl+U]" class="se2_underline"><span class="_buttonRound">??????[Ctrl+U]</span></button></li>

				<li class="husky_seditor_ui_italic"><button type="button" title="????????????[Ctrl+I]" class="se2_italic"><span class="_buttonRound">????????????[Ctrl+I]</span></button></li>

				<li class="husky_seditor_ui_lineThrough"><button type="button" title="?????????[Ctrl+D]" class="se2_tdel"><span class="_buttonRound">?????????[Ctrl+D]</span></button></li>

				<li class="se2_pair husky_seditor_ui_fontColor"><span class="selected_color husky_se2m_fontColor_lastUsed" style="background-color:#4477f9"></span><span class="husky_seditor_ui_fontColorA"><button type="button" title="?????????" class="se2_fcolor"><span>?????????</span></button></span><span class="husky_seditor_ui_fontColorB"><button type="button" title="?????????" class="se2_fcolor_more"><span class="_buttonRound">?????????</span></button></span>				
					<!-- ????????? -->
					<div class="se2_layer husky_se2m_fontcolor_layer" style="display:none">
						<div class="se2_in_layer husky_se2m_fontcolor_paletteHolder">
							<div class="se2_palette husky_se2m_color_palette">
								<ul class="se2_pick_color">
								<li><button type="button" title="#ff0000" style="background:#ff0000"><span><span>#ff0000</span></span></button></li>
								<li><button type="button" title="#ff6c00" style="background:#ff6c00"><span><span>#ff6c00</span></span></button></li>
								<li><button type="button" title="#ffaa00" style="background:#ffaa00"><span><span>#ffaa00</span></span></button></li>
								<li><button type="button" title="#ffef00" style="background:#ffef00"><span><span>#ffef00</span></span></button></li>
								<li><button type="button" title="#a6cf00" style="background:#a6cf00"><span><span>#a6cf00</span></span></button></li>
								<li><button type="button" title="#009e25" style="background:#009e25"><span><span>#009e25</span></span></button></li>
								<li><button type="button" title="#00b0a2" style="background:#00b0a2"><span><span>#00b0a2</span></span></button></li>
								<li><button type="button" title="#0075c8" style="background:#0075c8"><span><span>#0075c8</span></span></button></li>
								<li><button type="button" title="#3a32c3" style="background:#3a32c3"><span><span>#3a32c3</span></span></button></li>
								<li><button type="button" title="#7820b9" style="background:#7820b9"><span><span>#7820b9</span></span></button></li>
								<li><button type="button" title="#ef007c" style="background:#ef007c"><span><span>#ef007c</span></span></button></li>
								<li><button type="button" title="#000000" style="background:#000000"><span><span>#000000</span></span></button></li>
								<li><button type="button" title="#252525" style="background:#252525"><span><span>#252525</span></span></button></li>
								<li><button type="button" title="#464646" style="background:#464646"><span><span>#464646</span></span></button></li>
								<li><button type="button" title="#636363" style="background:#636363"><span><span>#636363</span></span></button></li>
								<li><button type="button" title="#7d7d7d" style="background:#7d7d7d"><span><span>#7d7d7d</span></span></button></li>
								<li><button type="button" title="#9a9a9a" style="background:#9a9a9a"><span><span>#9a9a9a</span></span></button></li>
								<li><button type="button" title="#ffe8e8" style="background:#ffe8e8"><span><span>#9a9a9a</span></span></button></li>
								<li><button type="button" title="#f7e2d2" style="background:#f7e2d2"><span><span>#f7e2d2</span></span></button></li>
								<li><button type="button" title="#f5eddc" style="background:#f5eddc"><span><span>#f5eddc</span></span></button></li>
								<li><button type="button" title="#f5f4e0" style="background:#f5f4e0"><span><span>#f5f4e0</span></span></button></li>
								<li><button type="button" title="#edf2c2" style="background:#edf2c2"><span><span>#edf2c2</span></span></button></li>
								<li><button type="button" title="#def7e5" style="background:#def7e5"><span><span>#def7e5</span></span></button></li>
								<li><button type="button" title="#d9eeec" style="background:#d9eeec"><span><span>#d9eeec</span></span></button></li>
								<li><button type="button" title="#c9e0f0" style="background:#c9e0f0"><span><span>#c9e0f0</span></span></button></li>
								<li><button type="button" title="#d6d4eb" style="background:#d6d4eb"><span><span>#d6d4eb</span></span></button></li>
								<li><button type="button" title="#e7dbed" style="background:#e7dbed"><span><span>#e7dbed</span></span></button></li>
								<li><button type="button" title="#f1e2ea" style="background:#f1e2ea"><span><span>#f1e2ea</span></span></button></li>
								<li><button type="button" title="#acacac" style="background:#acacac"><span><span>#acacac</span></span></button></li>
								<li><button type="button" title="#c2c2c2" style="background:#c2c2c2"><span><span>#c2c2c2</span></span></button></li>
								<li><button type="button" title="#cccccc" style="background:#cccccc"><span><span>#cccccc</span></span></button></li>
								<li><button type="button" title="#e1e1e1" style="background:#e1e1e1"><span><span>#e1e1e1</span></span></button></li>
								<li><button type="button" title="#ebebeb" style="background:#ebebeb"><span><span>#ebebeb</span></span></button></li>
								<li><button type="button" title="#ffffff" style="background:#ffffff"><span><span>#ffffff</span></span></button></li>
								</ul>
								<ul class="se2_pick_color" style="width:156px;">
								<li><button type="button" title="#e97d81" style="background:#e97d81"><span><span>#e97d81</span></span></button></li>
								<li><button type="button" title="#e19b73" style="background:#e19b73"><span><span>#e19b73</span></span></button></li>
								<li><button type="button" title="#d1b274" style="background:#d1b274"><span><span>#d1b274</span></span></button></li>
								<li><button type="button" title="#cfcca2" style="background:#cfcca2"><span><span>#cfcca2</span></span></button></li>
								<li><button type="button" title="#cfcca2" style="background:#cfcca2"><span><span>#cfcca2</span></span></button></li>
								<li><button type="button" title="#61b977" style="background:#61b977"><span><span>#61b977</span></span></button></li>
								<li><button type="button" title="#53aea8" style="background:#53aea8"><span><span>#53aea8</span></span></button></li>
								<li><button type="button" title="#518fbb" style="background:#518fbb"><span><span>#518fbb</span></span></button></li>
								<li><button type="button" title="#6a65bb" style="background:#6a65bb"><span><span>#6a65bb</span></span></button></li>
								<li><button type="button" title="#9a54ce" style="background:#9a54ce"><span><span>#9a54ce</span></span></button></li>
								<li><button type="button" title="#e573ae" style="background:#e573ae"><span><span>#e573ae</span></span></button></li>
								<li><button type="button" title="#5a504b" style="background:#5a504b"><span><span>#5a504b</span></span></button></li>
								<li><button type="button" title="#767b86" style="background:#767b86"><span><span>#767b86</span></span></button></li>
								<li><button type="button" title="#951015" style="background:#951015"><span><span>#951015</span></span></button></li>
								<li><button type="button" title="#6e391a" style="background:#6e391a"><span><span>#6e391a</span></span></button></li>
								<li><button type="button" title="#785c25" style="background:#785c25"><span><span>#785c25</span></span></button></li>
								<li><button type="button" title="#5f5b25" style="background:#5f5b25"><span><span>#5f5b25</span></span></button></li>
								<li><button type="button" title="#4c511f" style="background:#4c511f"><span><span>#4c511f</span></span></button></li>
								<li><button type="button" title="#1c4827" style="background:#1c4827"><span><span>#1c4827</span></span></button></li>
								<li><button type="button" title="#0d514c" style="background:#0d514c"><span><span>#0d514c</span></span></button></li>
								<li><button type="button" title="#1b496a" style="background:#1b496a"><span><span>#1b496a</span></span></button></li>
								<li><button type="button" title="#2b285f" style="background:#2b285f"><span><span>#2b285f</span></span></button></li>
								<li><button type="button" title="#45245b" style="background:#45245b"><span><span>#45245b</span></span></button></li>
								<li><button type="button" title="#721947" style="background:#721947"><span><span>#721947</span></span></button></li>
								<li><button type="button" title="#352e2c" style="background:#352e2c"><span><span>#352e2c</span></span></button></li>
								<li><button type="button" title="#3c3f45" style="background:#3c3f45"><span><span>#3c3f45</span></span></button></li>
								</ul>
								<button type="button" title="?????????" class="se2_view_more husky_se2m_color_palette_more_btn"><span>?????????</span></button>
								<div class="husky_se2m_color_palette_recent" style="display:none">
									<h4>?????? ????????? ???</h4>
									<ul class="se2_pick_color">
									<li></li>
									<!-- ?????? ????????? ??? ????????? -->
									<!-- <li><button type="button" title="#e97d81" style="background:#e97d81"><span><span>#e97d81</span></span></button></li> -->
									<!-- //?????? ????????? ??? ????????? -->
									</ul>
								</div>								
								<div class="se2_palette2 husky_se2m_color_palette_colorpicker">
									<!--form action="http://test.emoticon.naver.com/colortable/TextAdd.nhn" method="post"-->
										<div class="se2_color_set">
											<span class="se2_selected_color"><span class="husky_se2m_cp_preview" style="background:#e97d81"></span></span><input type="text" name="" class="input_ty1 husky_se2m_cp_colorcode" value="#e97d81"><button type="button" class="se2_btn_insert husky_se2m_color_palette_ok_btn" title="??????"><span>??????</span></button></div>
										<!--input type="hidden" name="callback" value="http://test.emoticon.naver.com/colortable/result.jsp" />
										<input type="hidden" name="callback_func" value="1" />
										<input type="hidden" name="text_key" value="" />
										<input type="hidden" name="text_data" value="" />
									</form-->
									<div class="se2_gradation1 husky_se2m_cp_colpanel"></div>
									<div class="se2_gradation2 husky_se2m_cp_huepanel"></div>
								</div>
							</div>
                        </div>
					</div>
                    <!-- //????????? -->
				</li>

				<li class="se2_pair husky_seditor_ui_BGColor"><span class="selected_color husky_se2m_BGColor_lastUsed" style="background-color:#4477f9"></span><span class="husky_seditor_ui_BGColorA"><button type="button" title="?????????" class="se2_bgcolor"><span>?????????</span></button></span><span class="husky_seditor_ui_BGColorB"><button type="button" title="?????????" class="se2_bgcolor_more"><span class="_buttonRound">?????????</span></button></span>
					<!-- ????????? -->
					<div class="se2_layer se2_layer husky_se2m_BGColor_layer" style="display:none">
						<div class="se2_in_layer">
							<div class="se2_palette_bgcolor">
								<ul class="se2_background husky_se2m_bgcolor_list">
								<li><button type="button" title="?????????#ff0000 ?????????#ffffff" style="background:#ff0000; color:#ffffff"><span><span>?????????</span></span></button></li>								
								<li><button type="button" title="?????????#6d30cf ?????????#ffffff" style="background:#6d30cf; color:#ffffff"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#000000 ?????????#ffffff" style="background:#000000; color:#ffffff"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#ff6600 ?????????#ffffff" style="background:#ff6600; color:#ffffff"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#3333cc ?????????#ffffff" style="background:#3333cc; color:#ffffff"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#333333 ?????????#ffff00" style="background:#333333; color:#ffff00"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#ffa700 ?????????#ffffff" style="background:#ffa700; color:#ffffff"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#009999 ?????????#ffffff" style="background:#009999; color:#ffffff"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#8e8e8e ?????????#ffffff" style="background:#8e8e8e; color:#ffffff"><span><span>?????????</span></span></button></li>								
								<li><button type="button" title="?????????#cc9900 ?????????#ffffff" style="background:#cc9900; color:#ffffff"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#77b02b ?????????#ffffff" style="background:#77b02b; color:#ffffff"><span><span>?????????</span></span></button></li>
								<li><button type="button" title="?????????#ffffff ?????????#000000" style="background:#ffffff; color:#000000"><span><span>?????????</span></span></button></li>
								</ul>
							</div>
							<div class="husky_se2m_BGColor_paletteHolder"></div>
                        </div>
					</div>
                    <!-- //????????? -->
				</li>

				<li class="husky_seditor_ui_superscript"><button type="button" title="?????????" class="se2_sup"><span class="_buttonRound">?????????</span></button></li>

				<li class="husky_seditor_ui_subscript last_child"><button type="button" title="????????????" class="se2_sub"><span class="_buttonRound tool_bg">????????????</span></button></li>
</ul><ul>
				<li class="husky_seditor_ui_justifyleft first_child"><button type="button" title="????????????" class="se2_left"><span class="_buttonRound tool_bg">????????????</span></button></li>

				<li class="husky_seditor_ui_justifycenter"><button type="button" title="???????????????" class="se2_center"><span class="_buttonRound">???????????????</span></button></li>

				<li class="husky_seditor_ui_justifyright"><button type="button" title="???????????????" class="se2_right"><span class="_buttonRound">???????????????</span></button></li>

				<li class="husky_seditor_ui_justifyfull"><button type="button" title="????????????" class="se2_justify"><span class="_buttonRound">????????????</span></button></li>

				<li class="husky_seditor_ui_orderedlist"><button type="button" title="???????????????" class="se2_ol"><span class="_buttonRound">???????????????</span></button></li>

				<li class="husky_seditor_ui_unorderedlist"><button type="button" title="???????????????" class="se2_ul"><span class="_buttonRound">???????????????</span></button></li>

				<li class="husky_seditor_ui_outdent"><button type="button" title="????????????[Shift+Tab]" class="se2_outdent"><span class="_buttonRound">????????????[Shift+Tab]</span></button></li>

				<li class="husky_seditor_ui_indent"><button type="button" title="????????????[Tab]" class="se2_indent"><span class="_buttonRound">????????????[Tab]</span></button></li>			

				<li class="husky_seditor_ui_lineHeight last_child"><button type="button" title="?????????" class="se2_lineheight" ><span class="_buttonRound tool_bg">?????????</span></button>
					<!-- ????????? ????????? -->
					<div class="se2_layer husky_se2m_lineHeight_layer">
						<div class="se2_in_layer">
							<ul class="se2_l_line_height">
							<li><button type="button"><span>50%</span></button></li>
							<li><button type="button"><span>80%</span></button></li>
							<li><button type="button"><span>100%</span></button></li>
							<li><button type="button"><span>120%</span></button></li>
							<li><button type="button"><span>150%</span></button></li>
							<li><button type="button"><span>180%</span></button></li>
							<li><button type="button"><span>200%</span></button></li>
							</ul>
							<div class="se2_l_line_height_user husky_se2m_lineHeight_direct_input">
								<h3>?????? ??????</h3>
								<span class="bx_input">
								<input type="text" class="input_ty1" maxlength="3" style="width:75px">
								<button type="button" title="1% ?????????" class="btn_up"><span>1% ?????????</span></button>
								<button type="button" title="1% ??????" class="btn_down"><span>1% ??????</span></button>
								</span>		
								<div class="btn_area">
									<button type="button" class="se2_btn_apply3"><span>??????</span></button><button type="button" class="se2_btn_cancel3"><span>??????</span></button>
								</div>
							</div>
						</div>
					</div>
					<!-- //????????? ????????? -->
				</li>
</ul><ul>
				<li class="husky_seditor_ui_quote single_child"><button type="button" title="?????????" class="se2_blockquote"><span class="_buttonRound tool_bg">?????????</span></button>
					<!-- ????????? -->
					<div class="se2_layer husky_seditor_blockquote_layer" style="margin-left:-407px; display:none;">
						<div class="se2_in_layer">
							<div class="se2_quote">
								<ul>
								<li class="q1"><button type="button" class="se2_quote1"><span><span>????????? ?????????1</span></span></button></li>
								<li class="q2"><button type="button" class="se2_quote2"><span><span>????????? ?????????2</span></span></button></li>
								<li class="q3"><button type="button" class="se2_quote3"><span><span>????????? ?????????3</span></span></button></li>
								<li class="q4"><button type="button" class="se2_quote4"><span><span>????????? ?????????4</span></span></button></li>
								<li class="q5"><button type="button" class="se2_quote5"><span><span>????????? ?????????5</span></span></button></li>
								<li class="q6"><button type="button" class="se2_quote6"><span><span>????????? ?????????6</span></span></button></li>
								<li class="q7"><button type="button" class="se2_quote7"><span><span>????????? ?????????7</span></span></button></li>
								<li class="q8"><button type="button" class="se2_quote8"><span><span>????????? ?????????8</span></span></button></li>
								<li class="q9"><button type="button" class="se2_quote9"><span><span>????????? ?????????9</span></span></button></li>
								<li class="q10"><button type="button" class="se2_quote10"><span><span>????????? ?????????10</span></span></button></li>
								</ul>
								<button type="button" class="se2_cancel2"><span>????????????</span></button>
							</div>
						</div>
					</div>
					<!-- //????????? -->
				</li>
</ul><ul>
				<li class="husky_seditor_ui_hyperlink first_child"><button type="button" title="??????" class="se2_url"><span class="_buttonRound tool_bg">??????</span></button>
					<!-- ?????? -->
					<div class="se2_layer" style="margin-left:-285px">
						<div class="se2_in_layer">
							<div class="se2_url2">
								<input type="text" class="input_ty1" value="http://">
								<p><input name="" id="target" type="checkbox" checked="checked" value="" /><label for="target">????????????</label></p>
								<button type="button" class="se2_apply"><span>??????</span></button><button type="button" class="se2_cancel"><span>??????</span></button>
							</div>
						</div>
					</div>
					<!-- //?????? -->
				</li>

				<li class="husky_seditor_ui_sCharacter"><button type="button" title="????????????" class="se2_character"><span class="_buttonRound">????????????</span></button>
					<!-- ???????????? -->
					<div class="se2_layer husky_seditor_sCharacter_layer" style="margin-left:-448px;">
						<div class="se2_in_layer">
							<div class="se2_bx_character">
								<ul class="se2_char_tab">
								<li class="active"><button type="button" title="????????????" class="se2_char1"><span>????????????</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- ???????????? ?????? -->
											<!-- <li class="hover"><button type="button"><span>???</span></button></li><li class="active"><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="????????? ??????" class="se2_char2"><span>????????? ??????</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- ????????? ?????? ?????? -->
											<!-- <li class="hover"><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>$</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>A</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="???,??????" class="se2_char3"><span>???,??????</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- ???,?????? ?????? -->
											<!-- <li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li class="hover"><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="??????" class="se2_char4"><span>??????</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- ?????? ?????? -->
											<!-- <li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="?????????,?????????" class="se2_char5"><span>?????????,?????????</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- ?????????,????????? ?????? -->
											<!-- <li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li class="hover"><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>I</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li><li><button type="button"><span>??</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="?????????" class="se2_char6"><span>?????????</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- ????????? ?????? -->
											<!-- <li><button type="button"><span>???</span></button></li><li class="hover"><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li><li><button type="button"><span>???</span></button></li> -->
										</ul>
									</div>
								</li>
								</ul>
								<p class="se2_apply_character">
									<label for="char_preview">????????? ??????</label> <input type="text" name="char_preview" id="char_preview" value="?????????????" class="input_ty1"><button type="button" class="se2_confirm"><span>??????</span></button><button type="button" class="se2_cancel husky_se2m_sCharacter_close"><span>??????</span></button>
								</p>
							</div>
						</div>
					</div>
					<!-- //???????????? -->
				</li>

				<li class="husky_seditor_ui_table"><button type="button" title="???" class="se2_table"><span class="_buttonRound">???</span></button>
					<!--@lazyload_html create_table-->
					<!-- ??? -->
					<div class="se2_layer husky_se2m_table_layer" style="margin-left:-171px">
						<div class="se2_in_layer">
							<div class="se2_table_set">
								<fieldset>
								<legend>?????? ??????</legend>
									<dl class="se2_cell_num">
									<dt><label for="row">???</label></dt>
									<dd><input id="row" name="" type="text" maxlength="2" value="4" class="input_ty2">
										<button type="button" class="se2_add"><span>1?????????</span></button>
										<button type="button" class="se2_del"><span>1?????????</span></button>
									</dd>
									<dt><label for="col">???</label></dt>
									<dd><input id="col" name="" type="text" maxlength="2" value="4" class="input_ty2">
										<button type="button" class="se2_add"><span>1?????????</span></button>
										<button type="button" class="se2_del"><span>1?????????</span></button>
									</dd>
									</dl>
									<table border="0" cellspacing="1" class="se2_pre_table husky_se2m_table_preview">
									<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									</tr>
									<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									</tr>
									<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									</tr>
									</table>
								</fieldset>
								<fieldset>
									<legend>??????????????????</legend>
									<dl class="se2_t_proper1">
									<dt><input type="radio" id="se2_tbp1" name="se2_tbp" checked><label for="se2_tbp1">??????????????????</label></dt>
									<dd>
										<dl class="se2_t_proper1_1">
										<dt><label>????????????</label></dt>
										<dd><div class="se2_select_ty1"><span class="se2_b_style3 husky_se2m_table_border_style_preview"></span><button type="button" title="?????????" class="se2_view_more"><span>?????????</span></button></div>
											<!-- ????????? : ?????????????????? -->
											<div class="se2_layer_b_style husky_se2m_table_border_style_layer" style="display:none">
												<ul>
												<li><button type="button" class="se2_b_style1"><span class="se2m_no_border">???????????????</span></button></li>
												<li><button type="button" class="se2_b_style2"><span><span>??????????????????2</span></span></button></li>
												<li><button type="button" class="se2_b_style3"><span><span>??????????????????3</span></span></button></li>
												<li><button type="button" class="se2_b_style4"><span><span>??????????????????4</span></span></button></li>
												<li><button type="button" class="se2_b_style5"><span><span>??????????????????5</span></span></button></li>
												<li><button type="button" class="se2_b_style6"><span><span>??????????????????6</span></span></button></li>
												<li><button type="button" class="se2_b_style7"><span><span>??????????????????7</span></span></button></li>
												</ul>
											</div>
											<!-- //????????? : ?????????????????? -->
										</dd>
										</dl>
										<dl class="se2_t_proper1_1 se2_t_proper1_2">
										<dt><label for="se2_b_width">???????????????</label></dt>
										<dd><input id="se2_b_width" name="" type="text" maxlength="2" value="1" class="input_ty1">
											<button type="button" title="1px ?????????" class="se2_add se2m_incBorder"><span>1px ?????????</span></button>
											<button type="button" title="1px ??????" class="se2_del se2m_decBorder"><span>1px ??????</span></button>
										</dd>
										</dl>
										<dl class="se2_t_proper1_1 se2_t_proper1_3">
										<dt><label for="se2_b_color">????????????</label></dt>
										<dd><input id="se2_b_color" name="" type="text" maxlength="7" value="#cccccc" class="input_ty3"><span class="se2_pre_color"><button type="button" style="background:#cccccc;"><span>?????????</span></button></span>	
										<!-- ????????? : ???????????? -->
											<div class="se2_layer se2_b_t_b1" style="clear:both;display:none;position:absolute;top:20px;left:-147px;">
												<div class="se2_in_layer husky_se2m_table_border_color_pallet">
												</div>
											</div>
										<!-- //????????? : ????????????-->
										</dd>
										</dl>
										<div class="se2_t_dim0"></div><!-- ????????? ???????????? ??????????????? -->
										<dl class="se2_t_proper1_1 se2_t_proper1_4">
										<dt><label for="se2_cellbg">??? ?????????</label></dt>
										<dd><input id="se2_cellbg" name="" type="text" maxlength="7" value="#ffffff" class="input_ty3"><span class="se2_pre_color"><button type="button" style="background:#ffffff;"><span>?????????</span></button></span>
										<!-- ????????? : ???????????? -->
										<div class="se2_layer se2_b_t_b1" style="clear:both;display:none;position:absolute;top:20px;left:-147px;">
											<div class="se2_in_layer husky_se2m_table_bgcolor_pallet">
											</div>
										</div>
										<!-- //????????? : ????????????-->
										</dd>
										</dl>
									</dd>
									</dl>
								</fieldset>
								<fieldset>
									<legend>????????????</legend>
									<dl class="se2_t_proper2">
									<dt><input type="radio" id="se2_tbp2" name="se2_tbp"><label for="se2_tbp2">????????? ??????</label></dt>
									<dd><div class="se2_select_ty2"><span class="se2_t_style1 husky_se2m_table_style_preview"></span><button type="button" title="?????????" class="se2_view_more"><span>?????????</span></button></div>
										<!-- ????????? : ?????????????????? -->
										<div class="se2_layer_t_style husky_se2m_table_style_layer" style="display:none">
											<ul class="se2_scroll">
											<li><button type="button" class="se2_t_style1"><span>????????????1</span></button></li>
											<li><button type="button" class="se2_t_style2"><span>????????????2</span></button></li>
											<li><button type="button" class="se2_t_style3"><span>????????????3</span></button></li>
											<li><button type="button" class="se2_t_style4"><span>????????????4</span></button></li>
											<li><button type="button" class="se2_t_style5"><span>????????????5</span></button></li>
											<li><button type="button" class="se2_t_style6"><span>????????????6</span></button></li>
											<li><button type="button" class="se2_t_style7"><span>????????????7</span></button></li>
											<li><button type="button" class="se2_t_style8"><span>????????????8</span></button></li>
											<li><button type="button" class="se2_t_style9"><span>????????????9</span></button></li>
											<li><button type="button" class="se2_t_style10"><span>????????????10</span></button></li>
											<li><button type="button" class="se2_t_style11"><span>????????????11</span></button></li>
											<li><button type="button" class="se2_t_style12"><span>????????????12</span></button></li>
											<li><button type="button" class="se2_t_style13"><span>????????????13</span></button></li>
											<li><button type="button" class="se2_t_style14"><span>????????????14</span></button></li>
											<li><button type="button" class="se2_t_style15"><span>????????????15</span></button></li>
											<li><button type="button" class="se2_t_style16"><span>????????????16</span></button></li>
											</ul>
										</div>
										<!-- //????????? : ?????????????????? -->
									</dd>
									</dl>
								</fieldset>
								<p class="se2_btn_area">
									<button type="button" class="se2_apply"><span>??????</span></button><button type="button" class="se2_cancel"><span>??????</span></button>
								</p>
								<!-- ??????????????? -->
								<div class="se2_t_dim3"></div>
								<!-- //??????????????? -->
							</div>
						</div>
					</div>
					<!-- //??? -->
					<!--//@lazyload_html-->
				</li>
				<li class="image husky_seditor_ui_image" style="display:none;">
					<button type="button" title="????????? ??????" class="se2_image"><span>????????? ??????</span></button>
					<!-- ????????? ?????? ????????? -->
					<div class="layer husky_seditor_image_layer" style="margin-left:-238px;display:none;">
						<h3>????????? ??????</h3>
						<button type="button" class="close" title="????????? ?????? ????????? ??????"><span>????????? ?????? ????????? ??????</span></button>
						<div class="upload_area">
							<span class="help_text"></span>
							<span class="upload_btn" id="upload_btn" title="????????????"></span>
						</div>
						<div class="statusDefault">
			            	<p class="expdefault">?????? ?????? ?????? ????????? ??????</p>
			            </div>
			            <div class="statusOn">
			                <a class="iconAdd"></a>
			                <a class="explain_mouseOn">????????? ??????</a>
			            </div>
			            <div class="statusDrag"></div>
						<div class="list_area">
							<ul class="file_list"></ul>
						</div>
						<div class="btn_area">
							<button type="button" class="confirm" title="??????"><span>??????</span></button>
							<button type="button" class="cancel" title="??????"><span>??????</span></button>
						</div>
					</div>
					<!-- /????????? ?????? ????????? -->
				</li>
				<li class="movie husky_seditor_ui_movie" style="display:none;"><button type="button" title="????????? ??????" class="se2_movie"><span>????????? ??????</span></button></li>
				<li class="husky_seditor_ui_findAndReplace last_child"><button type="button" title="??????/?????????" class="se2_find"><span class="_buttonRound tool_bg">??????/?????????</span></button>
					<!--@lazyload_html find_and_replace-->
					<!-- ??????/????????? -->
					<div class="se2_layer husky_se2m_findAndReplace_layer" style="margin-left:-238px;">
						<div class="se2_in_layer">
							<div class="se2_bx_find_revise">
								<button type="button" title="??????" class="se2_close husky_se2m_cancel"><span>??????</span></button>
								<h3>??????/?????????</h3>
								<ul>
								<li class="active"><button type="button" class="se2_tabfind"><span>??????</span></button></li>
								<li><button type="button" class="se2_tabrevise"><span>?????????</span></button></li>
								</ul>
								<div class="se2_in_bx_find husky_se2m_find_ui" style="display:block">
									<dl>
									<dt><label for="find_word">?????? ??????</label></dt><dd><input type="text" id="find_word" value="??????????????????" class="input_ty1"></dd>
									</dl>
									<p class="se2_find_btns">
										<button type="button" class="se2_find_next husky_se2m_find_next"><span>?????? ??????</span></button><button type="button" class="se2_cancel husky_se2m_cancel"><span>??????</span></button>
									</p>
								</div>
								<div class="se2_in_bx_revise husky_se2m_replace_ui" style="display:none">
									<dl>
									<dt><label for="find_word2">?????? ??????</label></dt><dd><input type="text" id="find_word2" value="??????????????????" class="input_ty1"></dd>
									<dt><label for="revise_word">?????? ??????</label></dt><dd><input type="text" id="revise_word" value="??????????????????" class="input_ty1"></dd>
									</dl>
									<p class="se2_find_btns">
										<button type="button" class="se2_find_next2 husky_se2m_replace_find_next"><span>?????? ??????</span></button><button type="button" class="se2_revise1 husky_se2m_replace"><span>?????????</span></button><button type="button" class="se2_revise2 husky_se2m_replace_all"><span>?????? ?????????</span></button><button type="button" class="se2_cancel husky_se2m_cancel"><span>??????</span></button>
									</p>
								</div>
								<button type="button" title="??????" class="se2_close husky_se2m_cancel"><span>??????</span></button>
							</div>
						</div>
					</div>
					<!-- //??????/????????? -->
					<!--//@lazyload_html-->
				</li>
</ul>
			</div>
			<!-- //704?????? -->
		</div>
		
				<!-- ????????? ????????? ????????? -->
		<div class="se2_layer se2_accessibility" style="display:none;">
			<div class="se2_in_layer">
				<button type="button" title="??????" class="se2_close"><span>??????</span></button>
				<h3><strong>????????? ?????????</strong></h3>
				<div class="box_help">
					<div>
						<strong>??????</strong>
						<p>ALT+F10 ??? ????????? ????????? ???????????????. ?????? ????????? TAB ?????? ?????? ????????? SHIFT+TAB ?????? ?????? ???????????????. ENTER ??? ????????? ?????? ????????? ????????? ???????????? ????????? ???????????? ???????????? ???????????????. ESC ??? ????????? ????????? ????????? ???????????? ?????? ????????? ???????????? ???????????? ???????????????.</p>
						<strong>?????? ?????????</strong>
						<p>ALT+. ??? ????????? ????????? ????????? ?????? ????????? ALT+, ??? ????????? ?????????????????? ?????? ????????? ???????????? ??? ????????????.</p>
						<strong>????????? ?????????</strong>
						<ul>
						<li>CTRL+B <span>??????</span></li>
						<li>SHIFT+TAB <span>????????????</span></li>
						<li>CTRL+U <span>??????</span></li>
						<li>CTRL+F <span>??????</span></li>
						<li>CTRL+I <span>????????? ??????</span></li>
						<li>CTRL+H <span>?????????</span></li>
						<li>CTRL+D <span>?????????</span></li>
						<li>CTRL+K <span>????????????</span></li>
						<li>TAB <span>????????????</span></li>
						</ul>
					</div>
				</div>
				<div class="se2_btns">
					<button type="button" class="se2_close2"><span>??????</span></button>
				</div>
			</div>
		</div>		
		<!-- //????????? ????????? ????????? -->

		<hr>
		<!-- ?????? -->
		<div class="se2_input_area husky_seditor_editing_area_container">
			
			
			<iframe src="about:blank" id="se2_iframe" name="se2_iframe" class="se2_input_wysiwyg" width="400" height="300" title="????????? ?????? : ?????? ????????? ALT+F10???, ???????????? ALT+0??? ????????????." frameborder="0" style="display:block;"></iframe>
			<textarea name="" rows="10" cols="100" title="HTML ?????? ??????" class="se2_input_syntax se2_input_htmlsrc" style="display:none;outline-style:none;resize:none"> </textarea>
			<textarea name="" rows="10" cols="100" title="TEXT ?????? ??????" class="se2_input_syntax se2_input_text" style="display:none;outline-style:none;resize:none;"> </textarea>
			
			<!-- ????????? ?????? ?????? ????????? -->
			<div class="ly_controller husky_seditor_resize_notice" style="z-index:20;display:none;">
				<p>?????? ????????? ??????????????? ????????? ????????? ????????? ??? ????????????.</p>
				<button type="button" title="??????" class="bt_clse"><span>??????</span></button>
				<span class="ic_arr"></span>
			</div>
			<!-- //????????? ?????? ?????? ????????? -->
						<div class="quick_wrap">
				<!-- ???/????????? ??????????????? -->
				<!--@lazyload_html qe_table-->
				<div class="q_table_wrap" style="z-index: 150;">
				<button class="_fold se2_qmax q_open_table_full" style="position:absolute; display:none;top:340px;left:210px;z-index:30;" title="?????????" type="button"><span>?????????????????????</span></button>
				<div class="_full se2_qeditor se2_table_set" style="position:absolute;display:none;top:135px;left:661px;z-index:30;">
					<div class="se2_qbar q_dragable"><span class="se2_qmini"><button title="?????????" class="q_open_table_fold"><span>?????????????????????</span></button></span></div>
					<div class="se2_qbody0">
						<div class="se2_qbody">
							<dl class="se2_qe1">
							<dt>??????</dt><dd><button class="se2_addrow" title="?????????" type="button"><span>?????????</span></button><button class="se2_addcol" title="?????????" type="button"><span>?????????</span></button></dd>
							<dt>??????</dt><dd><button class="se2_seprow" title="?????????" type="button"><span>?????????</span></button><button class="se2_sepcol" title="?????????" type="button"><span>?????????</span></button></dd>

							<dt>??????</dt><dd><button class="se2_delrow" title="?????????" type="button"><span>?????????</span></button><button class="se2_delcol" title="?????????" type="button"><span>?????????</span></button></dd>
							<dt>??????</dt><dd><button class="se2_merrow" title="?????????" type="button"><span>?????????</span></button></dd>
							</dl>
							<div class="se2_qe2 se2_qe2_3"> <!-- ????????? ??????????????? ?????????,  se2_qe2_3?????? -->
								<!-- ???????????? -->
								<dl class="se2_qe2_1">

								<dt><input type="radio" checked="checked" name="se2_tbp3" id="se2_cellbg2" class="husky_se2m_radio_bgc"><label for="se2_cellbg2">??? ?????????</label></dt>
								<dd><span class="se2_pre_color"><button style="background: none repeat scroll 0% 0% rgb(255, 255, 255);" type="button" class="husky_se2m_table_qe_bgcolor_btn"><span>?????????</span></button></span>		
									<!-- layer:???????????? -->
									<div style="display:none;position:absolute;top:20px;left:0px;" class="se2_layer se2_b_t_b1">
										<div class="se2_in_layer husky_se2m_tbl_qe_bg_paletteHolder">
										</div>
									</div>
									<!-- //layer:????????????-->

								</dd>
								</dl>
								<!-- //???????????? -->
								<!-- ????????????????????? -->
								<dl style="display: none;" class="se2_qe2_2 husky_se2m_tbl_qe_review_bg">
								<dt><input type="radio" name="se2_tbp3" id="se2_cellbg3" class="husky_se2m_radio_bgimg"><label for="se2_cellbg3">?????????</label></dt>
								<dd><span class="se2_pre_bgimg"><button class="husky_se2m_table_qe_bgimage_btn se2_cellimg0" type="button"><span>?????????????????????</span></button></span>
									<!-- layer:????????????????????? -->
									<div style="display:none;position:absolute;top:20px;left:-155px;" class="se2_layer se2_b_t_b1">
										<div class="se2_in_layer husky_se2m_tbl_qe_bg_img_paletteHolder">
											<ul class="se2_cellimg_set">
											<li><button class="se2_cellimg0" type="button"><span>????????????</span></button></li>
											<li><button class="se2_cellimg1" type="button"><span>??????1</span></button></li>
											<li><button class="se2_cellimg2" type="button"><span>??????2</span></button></li>
											<li><button class="se2_cellimg3" type="button"><span>??????3</span></button></li>
											<li><button class="se2_cellimg4" type="button"><span>??????4</span></button></li>
											<li><button class="se2_cellimg5" type="button"><span>??????5</span></button></li>
											<li><button class="se2_cellimg6" type="button"><span>??????6</span></button></li>
											<li><button class="se2_cellimg7" type="button"><span>??????7</span></button></li>
											<li><button class="se2_cellimg8" type="button"><span>??????8</span></button></li>
											<li><button class="se2_cellimg9" type="button"><span>??????9</span></button></li>
											<li><button class="se2_cellimg10" type="button"><span>??????10</span></button></li>
											<li><button class="se2_cellimg11" type="button"><span>??????11</span></button></li>
											<li><button class="se2_cellimg12" type="button"><span>??????12</span></button></li>
											<li><button class="se2_cellimg13" type="button"><span>??????13</span></button></li>
											<li><button class="se2_cellimg14" type="button"><span>??????14</span></button></li>
											<li><button class="se2_cellimg15" type="button"><span>??????15</span></button></li>
											<li><button class="se2_cellimg16" type="button"><span>??????16</span></button></li>
											<li><button class="se2_cellimg17" type="button"><span>??????17</span></button></li>
											<li><button class="se2_cellimg18" type="button"><span>??????18</span></button></li>
											<li><button class="se2_cellimg19" type="button"><span>??????19</span></button></li>
											<li><button class="se2_cellimg20" type="button"><span>??????20</span></button></li>
											<li><button class="se2_cellimg21" type="button"><span>??????21</span></button></li>
											<li><button class="se2_cellimg22" type="button"><span>??????22</span></button></li>
											<li><button class="se2_cellimg23" type="button"><span>??????23</span></button></li>
											<li><button class="se2_cellimg24" type="button"><span>??????24</span></button></li>
											<li><button class="se2_cellimg25" type="button"><span>??????25</span></button></li>
											<li><button class="se2_cellimg26" type="button"><span>??????26</span></button></li>
											<li><button class="se2_cellimg27" type="button"><span>??????27</span></button></li>
											<li><button class="se2_cellimg28" type="button"><span>??????28</span></button></li>
											<li><button class="se2_cellimg29" type="button"><span>??????29</span></button></li>
											<li><button class="se2_cellimg30" type="button"><span>??????30</span></button></li>
											<li><button class="se2_cellimg31" type="button"><span>??????31</span></button></li>
											</ul>
										</div>
									</div>
									<!-- //layer:?????????????????????-->
								</dd>
								</dl>
								<!-- //????????????????????? -->
							</div>
							<dl style="display: block;" class="se2_qe3 se2_t_proper2">
							<dt><input type="radio" name="se2_tbp3" id="se2_tbp4" class="husky_se2m_radio_template"><label for="se2_tbp4">??? ?????????</label></dt>
							<dd>
								<div class="se2_qe3_table">
								<div class="se2_select_ty2"><span class="se2_t_style1"></span><button class="se2_view_more husky_se2m_template_more" title="?????????" type="button"><span>?????????</span></button></div>
								<!-- layer:???????????? -->
								<div style="display:none;top:33px;left:0;margin:0;" class="se2_layer_t_style">
									<ul>
									<li><button class="se2_t_style1" type="button"><span>??? ?????????1</span></button></li>
									<li><button class="se2_t_style2" type="button"><span>??? ?????????2</span></button></li>
									<li><button class="se2_t_style3" type="button"><span>??? ?????????3</span></button></li>
									<li><button class="se2_t_style4" type="button"><span>??? ?????????4</span></button></li>
									<li><button class="se2_t_style5" type="button"><span>??? ?????????5</span></button></li>
									<li><button class="se2_t_style6" type="button"><span>??? ?????????6</span></button></li>
									<li><button class="se2_t_style7" type="button"><span>??? ?????????7</span></button></li>
									<li><button class="se2_t_style8" type="button"><span>??? ?????????8</span></button></li>
									<li><button class="se2_t_style9" type="button"><span>??? ?????????9</span></button></li>
									<li><button class="se2_t_style10" type="button"><span>??? ?????????10</span></button></li>
									<li><button class="se2_t_style11" type="button"><span>??? ?????????11</span></button></li>
									<li><button class="se2_t_style12" type="button"><span>??? ?????????12</span></button></li>
									<li><button class="se2_t_style13" type="button"><span>??? ?????????13</span></button></li>
									<li><button class="se2_t_style14" type="button"><span>??? ?????????14</span></button></li>
									<li><button class="se2_t_style15" type="button"><span>??? ?????????15</span></button></li>
									<li><button class="se2_t_style16" type="button"><span>??? ?????????16</span></button></li>
									</ul>
								</div>
								<!-- //layer:???????????? -->
								</div>
							</dd>
							</dl>
							<div style="display:none" class="se2_btn_area">
								<button class="se2_btn_save" type="button"><span>My ????????????</span></button>
							</div>
							<div class="se2_qdim0 husky_se2m_tbl_qe_dim1"></div>
							<div class="se2_qdim4 husky_se2m_tbl_qe_dim2"></div>
							<div class="se2_qdim6c husky_se2m_tbl_qe_dim_del_col"></div>
							<div class="se2_qdim6r husky_se2m_tbl_qe_dim_del_row"></div>
						</div>
					</div>
				</div>
				</div>
				<!--//@lazyload_html-->
				<!-- //???/????????? ??????????????? -->
				<!-- ????????? ??????????????? -->
				<!--@lazyload_html qe_image-->
				<div class="q_img_wrap">
					<button class="_fold se2_qmax q_open_img_full" style="position:absolute;display:none;top:240px;left:210px;z-index:30;" title="?????????" type="button"><span>?????????????????????</span></button>
					<div class="_full_1 se2_qeditor se2_table_set" style="position:absolute;display:none;top:50%;left:50%;z-index:30;">
						<div class="se2_qbar  q_dragable"></div>
						<div class="se2_qbody0">
							<div class="se2_qbody">
								<div class="se2_qe10">
									<label for="se2_swidth">??????</label><input type="text" class="input_ty1 widthimg" name="" id="se2_swidth" value="1024"><label class="se2_sheight" for="se2_sheight">??????</label><input type="text" class="input_ty1 heightimg" name="" id="se2_sheight" value="768"><button class="se2_sreset" type="button"><span>?????????</span></button>
									<div class="se2_qe10_1"><input type="checkbox" checked="checked" name="" class="se2_srate" id="se2_srate"><label for="se2_srate">?????? ?????? ?????? ??????</label></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--//@lazyload_html-->
				<!-- ????????? ??????????????? -->
			</div>
		</div>
		<!-- //?????? -->
		<!-- ???????????????/ ???????????? -->
		<div class="se2_conversion_mode">
			<button type="button" class="se2_inputarea_controller husky_seditor_editingArea_verticalResizer" title="????????? ?????? ??????"><span>????????? ?????? ??????</span></button>
			<ul class="se2_converter">
			<li class="active"><button type="button" class="se2_to_editor"><span>Editor</span></button></li>
			<li><button type="button" class="se2_to_html"><span>HTML</span></button></li>
			<li><button type="button" class="se2_to_text"><span>TEXT</span></button></li>
			</ul>
		</div>
		<!-- //???????????????/ ???????????? -->
		<hr>
		
	</div>
</div>
<!-- SE2 Markup End -->

</body>
</html>