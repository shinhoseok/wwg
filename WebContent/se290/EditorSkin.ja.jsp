<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Smart Editor</title>
<%@ include file="/ekp/img/config.jsp" %>
<link href="css/default.ja.css" rel="stylesheet" type="text/css" />
<link href="css/smart_editor2.ja.css" rel="stylesheet" type="text/css">
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
<script type="text/javascript" src="<%= request.getContextPath() %>/lib/com/kcube/jsv/jsv-utils.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/sys/jsv/swfupload/swfupload.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/sys/jsv/swfupload/plugins/swfupload.queue.js"></script>

<script type="text/javascript" src="./js/lib/jindo2.all.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/lib/jindo_component.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/SE2M_Configuration.js" charset="utf-8"></script>	<!-- 설정 파일 -->
<script type="text/javascript" src="./js/SE2BasicCreator.js" charset="utf-8"></script>

<script src='js/smarteditor2.js' charset='utf-8'></script>
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
var _CONTEXT_PATH = "<%= request.getContextPath() %>";
var _ISMOVIE = "<%=com.kcube.sys.license.LicenseService.isAuthorized(com.kcube.sys.PlusAppBoot.MODULE_MOVIE)%>";
var _IMGFILESIZE = "<%=getFileSize()%>";
var _IMGLIMITTEXT = "<p>ファイルあたり " + (_IMGFILESIZE > 0 ? ("最大 <span class='limit_text'>" + Math.ceil(_IMGFILESIZE/1024 * 10)/10 + "MB</span>まで") : "制限なく") + "アップロードできます。<br/>また複数のファイルを添付することも可能です。</p>";
var _IMGCOUNT = "<%=getCount()%>";
var _FILECOUNTLIMIT_MSG = "最大転送可能なファイルの個数を超えて、キャンセルされました。";
var _CLOSE_MSG = "イメージを追加せずに、ウィンドウを閉じますか。";
var _FILE_EXCEEDS_SIZE_LIMIT = "ファイルあたりの最大容量を超えて、キャンセルされました。";
var _ZERO_BYTE_FILE = "0Btyeのファイルのためキャンセルされました。";
var _INVALID_FILETYPE =	"アップロードに制限されたファイル形態のため、キャンセルされました。";
var _UNKNOWN = "不明なエラーのためキャンセルされました。";
var _BTNTEXT = "ファイル追加";
var _LANG = 'ja_JP';
</script>
</head>
<body>
<!-- SE2 Markup Start -->	
<div id="smart_editor2">
	<div id="smart_editor2_content"><a href="#se2_iframe" class="blind">入力領域へ移動</a>
		<div class="se2_tool" id="se2_tool">
			
			<div class="se2_text_tool husky_seditor_text_tool">
			<ul class="se2_font_type">
				<li class="husky_seditor_ui_fontName"><button type="button" class="se2_font_family" title="フォント"><span class="husky_se2m_current_fontName">フォント</span></button>
					<!-- 글꼴 레이어 -->
					<div class="se2_layer husky_se_fontName_layer">
						<div class="se2_in_layer">
							<ul class="se2_l_font_fam">
							<!-- 다국어 처리를 위해서 smarteditor2.js 에 폰트 리스트를 가져오는 부분 주석처리. (line 11137 ~ 11148)-->
							<li style="display:none"><button type="button"><span>@DisplayName@<span>(</span><em style="font-family:FontFamily;">@SampleText@</em><span>)</span></span></button></li>
							<li><button type="button"><span>MS Gothic<span>(</span><em style="font-family:'MS Gothic',MS Gothic,Sans-serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>MS Mincho<span>(</span><em style="font-family:'MS Mincho',MS Mincho,Sans-serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>Meiryo<span>(</span><em style="font-family:'Meiryo',Meiryo,Sans-serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>Dotum<span>(</span><em style="font-family:'돋움',Dotum,Sans-serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>DotumChe<span>(</span><em style="font-family:'돋움체',DotumChe,Sans-serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>Gulim<span>(</span><em style="font-family:'굴림',Gulim,Sans-serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>GulimChe<span>(</span><em style="font-family:'굴림체',GulimChe,Sans-serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>Batang<span>(</span><em style="font-family:'바탕',Batang,serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>BatangChe<span>(</span><em style="font-family:'바탕체',BatangChe,serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>Gungsuh<span>(</span><em style="font-family:'궁서',Gungsuh,serif;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>Arial<span>(</span><em style="font-family:arial,Sans-serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>Tahoma<span>(</span><em style="font-family:tahoma,Sans-serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>Times New Roman<span>(</span><em style="font-family:'Times New Roman',Times,serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>Verdana<span>(</span><em style="font-family:verdana,Sans-serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>Courier New<span>(</span><em style="font-family:Courier New,Sans-serif;">abcd</em><span>)</span></span></button></li>
							<li><button type="button"><span>NanumGothic<span>(</span><em style="font-family:'나눔고딕',NanumGothic;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>NamumMyeongjo<span>(</span><em style="font-family:'나눔명조',NanumMyeongjo;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>NanumGothicCoding<span>(</span><em style="font-family:'나눔고딕코딩',NanumGothicCoding;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>NanumBarunGothic<span>(</span><em style="font-family:'나눔바른고딕',NanumBarunGothic;">あいうえお</em><span>)</span></span></button></li>
							<li><button type="button"><span>NanumBarunPen<span>(</span><em style="font-family:'나눔바른펜',NanumBarunPen;">あいうえお</em><span>)</span></span></button></li>
							</ul>
						</div>
					</div>
					<!-- //글꼴 레이어 -->
				</li>

				<li class="husky_seditor_ui_fontSize"><button type="button" class="se2_font_size" title="フォントサイズ"><span class="husky_se2m_current_fontSize">サイズ</span></button>
					<!-- 폰트 사이즈 레이어 -->
					<div class="se2_layer husky_se_fontSize_layer">
						<div class="se2_in_layer">
							<ul class="se2_l_font_size">
							<li><button type="button"><span style="margin-top:4px; margin-bottom:3px; margin-left:5px; font-size:7pt;">あいうえお<span style=" font-size:7pt;">(7pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:2px; font-size:8pt;">あいうえお<span style="font-size:8pt;">(8pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:1px; font-size:9pt;">あいうえお<span style="font-size:9pt;">(9pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:1px; font-size:10pt;">あいうえお<span style="font-size:10pt;">(10pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:2px; font-size:11pt;">あいうえお<span style="font-size:11pt;">(11pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:1px; font-size:12pt;">あいうえお<span style="font-size:12pt;">(12pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:2px; font-size:14pt;">あいうえお<span style="margin-left:6px;font-size:14pt;">(14pt)</span></span></button></li>
							<li><button type="button"><span style="margin-bottom:1px; font-size:18pt;">あいうえお<span style="margin-left:8px;font-size:18pt;">(18pt)</span></span></button></li>
							<li><button type="button"><span style="margin-left:3px; font-size:24pt;">あいうえお<span style="margin-left:11px;font-size:24pt;">(24pt)</span></span></button></li>
							<li><button type="button"><span style="margin-top:-1px; margin-left:3px; font-size:36pt;">あいうえお<span style="font-size:36pt;">(36pt)</span></span></button></li>
							</ul>
						</div>
					</div>
					<!-- //폰트 사이즈 레이어 -->
				</li>
</ul><ul>
				<li class="husky_seditor_ui_bold first_child"><button type="button" title="太字[Ctrl+B]" class="se2_bold"><span class="_buttonRound tool_bg">太字[Ctrl+B]</span></button></li>

				<li class="husky_seditor_ui_underline"><button type="button" title="下線[Ctrl+U]" class="se2_underline"><span class="_buttonRound">下線[Ctrl+U]</span></button></li>

				<li class="husky_seditor_ui_italic"><button type="button" title="斜体[Ctrl+I]" class="se2_italic"><span class="_buttonRound">斜体[Ctrl+I]</span></button></li>

				<li class="husky_seditor_ui_lineThrough"><button type="button" title="取り消し線[Ctrl+D]" class="se2_tdel"><span class="_buttonRound">取り消し線[Ctrl+D]</span></button></li>

				<li class="se2_pair husky_seditor_ui_fontColor"><span class="selected_color husky_se2m_fontColor_lastUsed" style="background-color:#4477f9"></span><span class="husky_seditor_ui_fontColorA"><button type="button" title="文字色" class="se2_fcolor"><span>文字色</span></button></span><span class="husky_seditor_ui_fontColorB"><button type="button" title="もっと見る" class="se2_fcolor_more"><span class="_buttonRound">もっと見る</span></button></span>				
					<!-- 글자색 -->
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
								<button type="button" title="もっと見る" class="se2_view_more husky_se2m_color_palette_more_btn"><span>もっと見る</span></button>
								<div class="husky_se2m_color_palette_recent" style="display:none">
									<h4>最近使用した色</h4>
									<ul class="se2_pick_color">
									<li></li>
									<!-- 최근 사용한 색 템플릿 -->
									<!-- <li><button type="button" title="#e97d81" style="background:#e97d81"><span><span>#e97d81</span></span></button></li> -->
									<!-- //최근 사용한 색 템플릿 -->
									</ul>
								</div>								
								<div class="se2_palette2 husky_se2m_color_palette_colorpicker">
									<!--form action="http://test.emoticon.naver.com/colortable/TextAdd.nhn" method="post"-->
										<div class="se2_color_set">
											<span class="se2_selected_color"><span class="husky_se2m_cp_preview" style="background:#e97d81"></span></span><input type="text" name="" class="input_ty1 husky_se2m_cp_colorcode" value="#e97d81"><button type="button" class="se2_btn_insert husky_se2m_color_palette_ok_btn" title="入力"><span>入力</span></button></div>
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
                    <!-- //글자색 -->
				</li>

				<li class="se2_pair husky_seditor_ui_BGColor"><span class="selected_color husky_se2m_BGColor_lastUsed" style="background-color:#4477f9"></span><span class="husky_seditor_ui_BGColorA"><button type="button" title="背景色" class="se2_bgcolor"><span>背景色</span></button></span><span class="husky_seditor_ui_BGColorB"><button type="button" title="もっと見る" class="se2_bgcolor_more"><span class="_buttonRound">もっと見る</span></button></span>
					<!-- 배경색 -->
					<div class="se2_layer se2_layer husky_se2m_BGColor_layer" style="display:none">
						<div class="se2_in_layer">
							<div class="se2_palette_bgcolor">
								<ul class="se2_background husky_se2m_bgcolor_list">
								<li><button type="button" title="背景色#ff0000 文字色#ffffff" style="background:#ff0000; color:#ffffff"><span><span>あいう</span></span></button></li>								
								<li><button type="button" title="背景色#6d30cf 文字色#ffffff" style="background:#6d30cf; color:#ffffff"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#000000 文字色#ffffff" style="background:#000000; color:#ffffff"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#ff6600 文字色#ffffff" style="background:#ff6600; color:#ffffff"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#3333cc 文字色#ffffff" style="background:#3333cc; color:#ffffff"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#333333 文字色#ffff00" style="background:#333333; color:#ffff00"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#ffa700 文字色#ffffff" style="background:#ffa700; color:#ffffff"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#009999 文字色#ffffff" style="background:#009999; color:#ffffff"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#8e8e8e 文字色#ffffff" style="background:#8e8e8e; color:#ffffff"><span><span>あいう</span></span></button></li>								
								<li><button type="button" title="背景色#cc9900 文字色#ffffff" style="background:#cc9900; color:#ffffff"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#77b02b 文字色#ffffff" style="background:#77b02b; color:#ffffff"><span><span>あいう</span></span></button></li>
								<li><button type="button" title="背景色#ffffff 文字色#000000" style="background:#ffffff; color:#000000"><span><span>あいう</span></span></button></li>
								</ul>
							</div>
							<div class="husky_se2m_BGColor_paletteHolder"></div>
                        </div>
					</div>
                    <!-- //배경색 -->
				</li>

				<li class="husky_seditor_ui_superscript"><button type="button" title="上付き" class="se2_sup"><span class="_buttonRound">上付き</span></button></li>

				<li class="husky_seditor_ui_subscript last_child"><button type="button" title="下付き" class="se2_sub"><span class="_buttonRound tool_bg">下付き</span></button></li>
</ul><ul>
				<li class="husky_seditor_ui_justifyleft first_child"><button type="button" title="左揃え" class="se2_left"><span class="_buttonRound tool_bg">左揃え</span></button></li>

				<li class="husky_seditor_ui_justifycenter"><button type="button" title="中央揃え" class="se2_center"><span class="_buttonRound">中央揃え</span></button></li>

				<li class="husky_seditor_ui_justifyright"><button type="button" title="右揃え" class="se2_right"><span class="_buttonRound">右揃え</span></button></li>

				<li class="husky_seditor_ui_justifyfull"><button type="button" title="両端揃え" class="se2_justify"><span class="_buttonRound">両端揃え</span></button></li>

				<li class="husky_seditor_ui_orderedlist"><button type="button" title="番号付け" class="se2_ol"><span class="_buttonRound">番号付け</span></button></li>

				<li class="husky_seditor_ui_unorderedlist"><button type="button" title="箇条書き" class="se2_ul"><span class="_buttonRound">箇条書き</span></button></li>

				<li class="husky_seditor_ui_outdent"><button type="button" title="逆インデント[Shift+Tab]" class="se2_outdent"><span class="_buttonRound">逆インデント[Shift+Tab]</span></button></li>

				<li class="husky_seditor_ui_indent"><button type="button" title="インデント[Tab]" class="se2_indent"><span class="_buttonRound">インデント[Tab]</span></button></li>			

				<li class="husky_seditor_ui_lineHeight last_child"><button type="button" title="行間" class="se2_lineheight" ><span class="_buttonRound tool_bg">行間</span></button>
					<!-- 줄간격 레이어 -->
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
								<h3>直接入力</h3>
								<span class="bx_input">
								<input type="text" class="input_ty1" maxlength="3" style="width:75px">
								<button type="button" title="1% 足す" class="btn_up"><span>1% 足す</span></button>
								<button type="button" title="1% 引く" class="btn_down"><span>1% 引く</span></button>
								</span>		
								<div class="btn_area">
									<button type="button" class="se2_btn_apply3"><span>適用</span></button><button type="button" class="se2_btn_cancel3"><span>취소</span></button>
								</div>
							</div>
						</div>
					</div>
					<!-- //줄간격 레이어 -->
				</li>
</ul><ul>
				<li class="husky_seditor_ui_quote single_child"><button type="button" title="引用" class="se2_blockquote"><span class="_buttonRound tool_bg">引用</span></button>
					<!-- 인용구 -->
					<div class="se2_layer husky_seditor_blockquote_layer" style="margin-left:-407px; display:none;">
						<div class="se2_in_layer">
							<div class="se2_quote">
								<ul>
								<li class="q1"><button type="button" class="se2_quote1"><span><span>引用スタイル1</span></span></button></li>
								<li class="q2"><button type="button" class="se2_quote2"><span><span>引用スタイル2</span></span></button></li>
								<li class="q3"><button type="button" class="se2_quote3"><span><span>引用スタイル3</span></span></button></li>
								<li class="q4"><button type="button" class="se2_quote4"><span><span>引用スタイル4</span></span></button></li>
								<li class="q5"><button type="button" class="se2_quote5"><span><span>引用スタイル5</span></span></button></li>
								<li class="q6"><button type="button" class="se2_quote6"><span><span>引用スタイル6</span></span></button></li>
								<li class="q7"><button type="button" class="se2_quote7"><span><span>引用スタイル7</span></span></button></li>
								<li class="q8"><button type="button" class="se2_quote8"><span><span>引用スタイル8</span></span></button></li>
								<li class="q9"><button type="button" class="se2_quote9"><span><span>引用スタイル9</span></span></button></li>
								<li class="q10"><button type="button" class="se2_quote10"><span><span>引用スタイル10</span></span></button></li>
								</ul>
								<button type="button" class="se2_cancel2"><span>適用キャンセル</span></button>
							</div>
						</div>
					</div>
					<!-- //인용구 -->
				</li>
</ul><ul>
				<li class="husky_seditor_ui_hyperlink first_child"><button type="button" title="リンク" class="se2_url"><span class="_buttonRound tool_bg">リンク</span></button>
					<!-- 링크 -->
					<div class="se2_layer" style="margin-left:-285px">
						<div class="se2_in_layer">
							<div class="se2_url2">
								<input type="text" class="input_ty1" value="http://">
								<p><input name="" id="target" type="checkbox" checked="checked" value="" /><label for="target">新しいウィンドウで</label></p>
								<button type="button" class="se2_apply"><span>適用</span></button><button type="button" class="se2_cancel"><span>キャンセル</span></button>
							</div>
						</div>
					</div>
					<!-- //링크 -->
				</li>

				<li class="husky_seditor_ui_sCharacter"><button type="button" title="特殊記号" class="se2_character"><span class="_buttonRound">特殊記号</span></button>
					<!-- 특수기호 -->
					<div class="se2_layer husky_seditor_sCharacter_layer" style="margin-left:-448px;">
						<div class="se2_in_layer">
							<div class="se2_bx_character">
								<ul class="se2_char_tab">
								<li class="active"><button type="button" title="一般記号" class="se2_char1"><span>一般記号</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- 일반기호 목록 -->
											<!-- <li class="hover"><button type="button"><span>｛</span></button></li><li class="active"><button type="button"><span>｝</span></button></li><li><button type="button"><span>〔</span></button></li><li><button type="button"><span>〕</span></button></li><li><button type="button"><span>〈</span></button></li><li><button type="button"><span>〉</span></button></li><li><button type="button"><span>《</span></button></li><li><button type="button"><span>》</span></button></li><li><button type="button"><span>「</span></button></li><li><button type="button"><span>」</span></button></li><li><button type="button"><span>『</span></button></li><li><button type="button"><span>』</span></button></li><li><button type="button"><span>【</span></button></li><li><button type="button"><span>】</span></button></li><li><button type="button"><span>‘</span></button></li><li><button type="button"><span>’</span></button></li><li><button type="button"><span>“</span></button></li><li><button type="button"><span>”</span></button></li><li><button type="button"><span>、</span></button></li><li><button type="button"><span>。</span></button></li><li><button type="button"><span>·</span></button></li><li><button type="button"><span>‥</span></button></li><li><button type="button"><span>…</span></button></li><li><button type="button"><span>§</span></button></li><li><button type="button"><span>※</span></button></li><li><button type="button"><span>☆</span></button></li><li><button type="button"><span>★</span></button></li><li><button type="button"><span>○</span></button></li><li><button type="button"><span>●</span></button></li><li><button type="button"><span>◎</span></button></li><li><button type="button"><span>◇</span></button></li><li><button type="button"><span>◆</span></button></li><li><button type="button"><span>□</span></button></li><li><button type="button"><span>■</span></button></li><li><button type="button"><span>△</span></button></li><li><button type="button"><span>▲</span></button></li><li><button type="button"><span>▽</span></button></li><li><button type="button"><span>▼</span></button></li><li><button type="button"><span>◁</span></button></li><li><button type="button"><span>◀</span></button></li><li><button type="button"><span>▷</span></button></li><li><button type="button"><span>▶</span></button></li><li><button type="button"><span>♤</span></button></li><li><button type="button"><span>♠</span></button></li><li><button type="button"><span>♡</span></button></li><li><button type="button"><span>♥</span></button></li><li><button type="button"><span>♧</span></button></li><li><button type="button"><span>♣</span></button></li><li><button type="button"><span>⊙</span></button></li><li><button type="button"><span>◈</span></button></li><li><button type="button"><span>▣</span></button></li><li><button type="button"><span>◐</span></button></li><li><button type="button"><span>◑</span></button></li><li><button type="button"><span>▒</span></button></li><li><button type="button"><span>▤</span></button></li><li><button type="button"><span>▥</span></button></li><li><button type="button"><span>▨</span></button></li><li><button type="button"><span>▧</span></button></li><li><button type="button"><span>▦</span></button></li><li><button type="button"><span>▩</span></button></li><li><button type="button"><span>±</span></button></li><li><button type="button"><span>×</span></button></li><li><button type="button"><span>÷</span></button></li><li><button type="button"><span>≠</span></button></li><li><button type="button"><span>≤</span></button></li><li><button type="button"><span>≥</span></button></li><li><button type="button"><span>∞</span></button></li><li><button type="button"><span>∴</span></button></li><li><button type="button"><span>°</span></button></li><li><button type="button"><span>′</span></button></li><li><button type="button"><span>″</span></button></li><li><button type="button"><span>∠</span></button></li><li><button type="button"><span>⊥</span></button></li><li><button type="button"><span>⌒</span></button></li><li><button type="button"><span>∂</span></button></li><li><button type="button"><span>≡</span></button></li><li><button type="button"><span>≒</span></button></li><li><button type="button"><span>≪</span></button></li><li><button type="button"><span>≫</span></button></li><li><button type="button"><span>√</span></button></li><li><button type="button"><span>∽</span></button></li><li><button type="button"><span>∝</span></button></li><li><button type="button"><span>∵</span></button></li><li><button type="button"><span>∫</span></button></li><li><button type="button"><span>∬</span></button></li><li><button type="button"><span>∈</span></button></li><li><button type="button"><span>∋</span></button></li><li><button type="button"><span>⊆</span></button></li><li><button type="button"><span>⊇</span></button></li><li><button type="button"><span>⊂</span></button></li><li><button type="button"><span>⊃</span></button></li><li><button type="button"><span>∪</span></button></li><li><button type="button"><span>∩</span></button></li><li><button type="button"><span>∧</span></button></li><li><button type="button"><span>∨</span></button></li><li><button type="button"><span>￢</span></button></li><li><button type="button"><span>⇒</span></button></li><li><button type="button"><span>⇔</span></button></li><li><button type="button"><span>∀</span></button></li><li><button type="button"><span>∃</span></button></li><li><button type="button"><span>´</span></button></li><li><button type="button"><span>～</span></button></li><li><button type="button"><span>ˇ</span></button></li><li><button type="button"><span>˘</span></button></li><li><button type="button"><span>˝</span></button></li><li><button type="button"><span>˚</span></button></li><li><button type="button"><span>˙</span></button></li><li><button type="button"><span>¸</span></button></li><li><button type="button"><span>˛</span></button></li><li><button type="button"><span>¡</span></button></li><li><button type="button"><span>¿</span></button></li><li><button type="button"><span>ː</span></button></li><li><button type="button"><span>∮</span></button></li><li><button type="button"><span>∑</span></button></li><li><button type="button"><span>∏</span></button></li><li><button type="button"><span>♭</span></button></li><li><button type="button"><span>♩</span></button></li><li><button type="button"><span>♪</span></button></li><li><button type="button"><span>♬</span></button></li><li><button type="button"><span>㉿</span></button></li><li><button type="button"><span>→</span></button></li><li><button type="button"><span>←</span></button></li><li><button type="button"><span>↑</span></button></li><li><button type="button"><span>↓</span></button></li><li><button type="button"><span>↔</span></button></li><li><button type="button"><span>↕</span></button></li><li><button type="button"><span>↗</span></button></li><li><button type="button"><span>↙</span></button></li><li><button type="button"><span>↖</span></button></li><li><button type="button"><span>↘</span></button></li><li><button type="button"><span>㈜</span></button></li><li><button type="button"><span>№</span></button></li><li><button type="button"><span>㏇</span></button></li><li><button type="button"><span>™</span></button></li><li><button type="button"><span>㏂</span></button></li><li><button type="button"><span>㏘</span></button></li><li><button type="button"><span>℡</span></button></li><li><button type="button"><span>♨</span></button></li><li><button type="button"><span>☏</span></button></li><li><button type="button"><span>☎</span></button></li><li><button type="button"><span>☜</span></button></li><li><button type="button"><span>☞</span></button></li><li><button type="button"><span>¶</span></button></li><li><button type="button"><span>†</span></button></li><li><button type="button"><span>‡</span></button></li><li><button type="button"><span>®</span></button></li><li><button type="button"><span>ª</span></button></li><li><button type="button"><span>º</span></button></li><li><button type="button"><span>♂</span></button></li><li><button type="button"><span>♀</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="数字と単位" class="se2_char2"><span>数字と単位</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- 숫자와 단위 목록 -->
											<!-- <li class="hover"><button type="button"><span>½</span></button></li><li><button type="button"><span>⅓</span></button></li><li><button type="button"><span>⅔</span></button></li><li><button type="button"><span>¼</span></button></li><li><button type="button"><span>¾</span></button></li><li><button type="button"><span>⅛</span></button></li><li><button type="button"><span>⅜</span></button></li><li><button type="button"><span>⅝</span></button></li><li><button type="button"><span>⅞</span></button></li><li><button type="button"><span>¹</span></button></li><li><button type="button"><span>²</span></button></li><li><button type="button"><span>³</span></button></li><li><button type="button"><span>⁴</span></button></li><li><button type="button"><span>ⁿ</span></button></li><li><button type="button"><span>₁</span></button></li><li><button type="button"><span>₂</span></button></li><li><button type="button"><span>₃</span></button></li><li><button type="button"><span>₄</span></button></li><li><button type="button"><span>Ⅰ</span></button></li><li><button type="button"><span>Ⅱ</span></button></li><li><button type="button"><span>Ⅲ</span></button></li><li><button type="button"><span>Ⅳ</span></button></li><li><button type="button"><span>Ⅴ</span></button></li><li><button type="button"><span>Ⅵ</span></button></li><li><button type="button"><span>Ⅶ</span></button></li><li><button type="button"><span>Ⅷ</span></button></li><li><button type="button"><span>Ⅸ</span></button></li><li><button type="button"><span>Ⅹ</span></button></li><li><button type="button"><span>ⅰ</span></button></li><li><button type="button"><span>ⅱ</span></button></li><li><button type="button"><span>ⅲ</span></button></li><li><button type="button"><span>ⅳ</span></button></li><li><button type="button"><span>ⅴ</span></button></li><li><button type="button"><span>ⅵ</span></button></li><li><button type="button"><span>ⅶ</span></button></li><li><button type="button"><span>ⅷ</span></button></li><li><button type="button"><span>ⅸ</span></button></li><li><button type="button"><span>ⅹ</span></button></li><li><button type="button"><span>￦</span></button></li><li><button type="button"><span>$</span></button></li><li><button type="button"><span>￥</span></button></li><li><button type="button"><span>￡</span></button></li><li><button type="button"><span>€</span></button></li><li><button type="button"><span>℃</span></button></li><li><button type="button"><span>A</span></button></li><li><button type="button"><span>℉</span></button></li><li><button type="button"><span>￠</span></button></li><li><button type="button"><span>¤</span></button></li><li><button type="button"><span>‰</span></button></li><li><button type="button"><span>㎕</span></button></li><li><button type="button"><span>㎖</span></button></li><li><button type="button"><span>㎗</span></button></li><li><button type="button"><span>ℓ</span></button></li><li><button type="button"><span>㎘</span></button></li><li><button type="button"><span>㏄</span></button></li><li><button type="button"><span>㎣</span></button></li><li><button type="button"><span>㎤</span></button></li><li><button type="button"><span>㎥</span></button></li><li><button type="button"><span>㎦</span></button></li><li><button type="button"><span>㎙</span></button></li><li><button type="button"><span>㎚</span></button></li><li><button type="button"><span>㎛</span></button></li><li><button type="button"><span>㎜</span></button></li><li><button type="button"><span>㎝</span></button></li><li><button type="button"><span>㎞</span></button></li><li><button type="button"><span>㎟</span></button></li><li><button type="button"><span>㎠</span></button></li><li><button type="button"><span>㎡</span></button></li><li><button type="button"><span>㎢</span></button></li><li><button type="button"><span>㏊</span></button></li><li><button type="button"><span>㎍</span></button></li><li><button type="button"><span>㎎</span></button></li><li><button type="button"><span>㎏</span></button></li><li><button type="button"><span>㏏</span></button></li><li><button type="button"><span>㎈</span></button></li><li><button type="button"><span>㎉</span></button></li><li><button type="button"><span>㏈</span></button></li><li><button type="button"><span>㎧</span></button></li><li><button type="button"><span>㎨</span></button></li><li><button type="button"><span>㎰</span></button></li><li><button type="button"><span>㎱</span></button></li><li><button type="button"><span>㎲</span></button></li><li><button type="button"><span>㎳</span></button></li><li><button type="button"><span>㎴</span></button></li><li><button type="button"><span>㎵</span></button></li><li><button type="button"><span>㎶</span></button></li><li><button type="button"><span>㎷</span></button></li><li><button type="button"><span>㎸</span></button></li><li><button type="button"><span>㎹</span></button></li><li><button type="button"><span>㎀</span></button></li><li><button type="button"><span>㎁</span></button></li><li><button type="button"><span>㎂</span></button></li><li><button type="button"><span>㎃</span></button></li><li><button type="button"><span>㎄</span></button></li><li><button type="button"><span>㎺</span></button></li><li><button type="button"><span>㎻</span></button></li><li><button type="button"><span>㎼</span></button></li><li><button type="button"><span>㎽</span></button></li><li><button type="button"><span>㎾</span></button></li><li><button type="button"><span>㎿</span></button></li><li><button type="button"><span>㎐</span></button></li><li><button type="button"><span>㎑</span></button></li><li><button type="button"><span>㎒</span></button></li><li><button type="button"><span>㎓</span></button></li><li><button type="button"><span>㎔</span></button></li><li><button type="button"><span>Ω</span></button></li><li><button type="button"><span>㏀</span></button></li><li><button type="button"><span>㏁</span></button></li><li><button type="button"><span>㎊</span></button></li><li><button type="button"><span>㎋</span></button></li><li><button type="button"><span>㎌</span></button></li><li><button type="button"><span>㏖</span></button></li><li><button type="button"><span>㏅</span></button></li><li><button type="button"><span>㎭</span></button></li><li><button type="button"><span>㎮</span></button></li><li><button type="button"><span>㎯</span></button></li><li><button type="button"><span>㏛</span></button></li><li><button type="button"><span>㎩</span></button></li><li><button type="button"><span>㎪</span></button></li><li><button type="button"><span>㎫</span></button></li><li><button type="button"><span>㎬</span></button></li><li><button type="button"><span>㏝</span></button></li><li><button type="button"><span>㏐</span></button></li><li><button type="button"><span>㏓</span></button></li><li><button type="button"><span>㏃</span></button></li><li><button type="button"><span>㏉</span></button></li><li><button type="button"><span>㏜</span></button></li><li><button type="button"><span>㏆</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="円,括弧" class="se2_char3"><span>円,括弧</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- 원,괄호 목록 -->
											<!-- <li><button type="button"><span>㉠</span></button></li><li><button type="button"><span>㉡</span></button></li><li><button type="button"><span>㉢</span></button></li><li><button type="button"><span>㉣</span></button></li><li><button type="button"><span>㉤</span></button></li><li><button type="button"><span>㉥</span></button></li><li><button type="button"><span>㉦</span></button></li><li><button type="button"><span>㉧</span></button></li><li><button type="button"><span>㉨</span></button></li><li><button type="button"><span>㉩</span></button></li><li><button type="button"><span>㉪</span></button></li><li><button type="button"><span>㉫</span></button></li><li><button type="button"><span>㉬</span></button></li><li><button type="button"><span>㉭</span></button></li><li><button type="button"><span>㉮</span></button></li><li><button type="button"><span>㉯</span></button></li><li><button type="button"><span>㉰</span></button></li><li><button type="button"><span>㉱</span></button></li><li><button type="button"><span>㉲</span></button></li><li><button type="button"><span>㉳</span></button></li><li><button type="button"><span>㉴</span></button></li><li><button type="button"><span>㉵</span></button></li><li><button type="button"><span>㉶</span></button></li><li><button type="button"><span>㉷</span></button></li><li><button type="button"><span>㉸</span></button></li><li><button type="button"><span>㉹</span></button></li><li><button type="button"><span>㉺</span></button></li><li><button type="button"><span>㉻</span></button></li><li><button type="button"><span>ⓐ</span></button></li><li><button type="button"><span>ⓑ</span></button></li><li><button type="button"><span>ⓒ</span></button></li><li><button type="button"><span>ⓓ</span></button></li><li><button type="button"><span>ⓔ</span></button></li><li><button type="button"><span>ⓕ</span></button></li><li><button type="button"><span>ⓖ</span></button></li><li><button type="button"><span>ⓗ</span></button></li><li><button type="button"><span>ⓘ</span></button></li><li><button type="button"><span>ⓙ</span></button></li><li><button type="button"><span>ⓚ</span></button></li><li><button type="button"><span>ⓛ</span></button></li><li><button type="button"><span>ⓜ</span></button></li><li><button type="button"><span>ⓝ</span></button></li><li><button type="button"><span>ⓞ</span></button></li><li><button type="button"><span>ⓟ</span></button></li><li><button type="button"><span>ⓠ</span></button></li><li><button type="button"><span>ⓡ</span></button></li><li><button type="button"><span>ⓢ</span></button></li><li><button type="button"><span>ⓣ</span></button></li><li><button type="button"><span>ⓤ</span></button></li><li><button type="button"><span>ⓥ</span></button></li><li><button type="button"><span>ⓦ</span></button></li><li><button type="button"><span>ⓧ</span></button></li><li><button type="button"><span>ⓨ</span></button></li><li><button type="button"><span>ⓩ</span></button></li><li><button type="button"><span>①</span></button></li><li><button type="button"><span>②</span></button></li><li><button type="button"><span>③</span></button></li><li><button type="button"><span>④</span></button></li><li><button type="button"><span>⑤</span></button></li><li><button type="button"><span>⑥</span></button></li><li><button type="button"><span>⑦</span></button></li><li><button type="button"><span>⑧</span></button></li><li><button type="button"><span>⑨</span></button></li><li><button type="button"><span>⑩</span></button></li><li><button type="button"><span>⑪</span></button></li><li><button type="button"><span>⑫</span></button></li><li><button type="button"><span>⑬</span></button></li><li><button type="button"><span>⑭</span></button></li><li><button type="button"><span>⑮</span></button></li><li><button type="button"><span>㈀</span></button></li><li><button type="button"><span>㈁</span></button></li><li class="hover"><button type="button"><span>㈂</span></button></li><li><button type="button"><span>㈃</span></button></li><li><button type="button"><span>㈄</span></button></li><li><button type="button"><span>㈅</span></button></li><li><button type="button"><span>㈆</span></button></li><li><button type="button"><span>㈇</span></button></li><li><button type="button"><span>㈈</span></button></li><li><button type="button"><span>㈉</span></button></li><li><button type="button"><span>㈊</span></button></li><li><button type="button"><span>㈋</span></button></li><li><button type="button"><span>㈌</span></button></li><li><button type="button"><span>㈍</span></button></li><li><button type="button"><span>㈎</span></button></li><li><button type="button"><span>㈏</span></button></li><li><button type="button"><span>㈐</span></button></li><li><button type="button"><span>㈑</span></button></li><li><button type="button"><span>㈒</span></button></li><li><button type="button"><span>㈓</span></button></li><li><button type="button"><span>㈔</span></button></li><li><button type="button"><span>㈕</span></button></li><li><button type="button"><span>㈖</span></button></li><li><button type="button"><span>㈗</span></button></li><li><button type="button"><span>㈘</span></button></li><li><button type="button"><span>㈙</span></button></li><li><button type="button"><span>㈚</span></button></li><li><button type="button"><span>㈛</span></button></li><li><button type="button"><span>⒜</span></button></li><li><button type="button"><span>⒝</span></button></li><li><button type="button"><span>⒞</span></button></li><li><button type="button"><span>⒟</span></button></li><li><button type="button"><span>⒠</span></button></li><li><button type="button"><span>⒡</span></button></li><li><button type="button"><span>⒢</span></button></li><li><button type="button"><span>⒣</span></button></li><li><button type="button"><span>⒤</span></button></li><li><button type="button"><span>⒥</span></button></li><li><button type="button"><span>⒦</span></button></li><li><button type="button"><span>⒧</span></button></li><li><button type="button"><span>⒨</span></button></li><li><button type="button"><span>⒩</span></button></li><li><button type="button"><span>⒪</span></button></li><li><button type="button"><span>⒫</span></button></li><li><button type="button"><span>⒬</span></button></li><li><button type="button"><span>⒭</span></button></li><li><button type="button"><span>⒮</span></button></li><li><button type="button"><span>⒯</span></button></li><li><button type="button"><span>⒰</span></button></li><li><button type="button"><span>⒱</span></button></li><li><button type="button"><span>⒲</span></button></li><li><button type="button"><span>⒳</span></button></li><li><button type="button"><span>⒴</span></button></li><li><button type="button"><span>⒵</span></button></li><li><button type="button"><span>⑴</span></button></li><li><button type="button"><span>⑵</span></button></li><li><button type="button"><span>⑶</span></button></li><li><button type="button"><span>⑷</span></button></li><li><button type="button"><span>⑸</span></button></li><li><button type="button"><span>⑹</span></button></li><li><button type="button"><span>⑺</span></button></li><li><button type="button"><span>⑻</span></button></li><li><button type="button"><span>⑼</span></button></li><li><button type="button"><span>⑽</span></button></li><li><button type="button"><span>⑾</span></button></li><li><button type="button"><span>⑿</span></button></li><li><button type="button"><span>⒀</span></button></li><li><button type="button"><span>⒁</span></button></li><li><button type="button"><span>⒂</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="ハングル" class="se2_char4"><span>ハングル</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- 한글 목록 -->
											<!-- <li><button type="button"><span>ㄱ</span></button></li><li><button type="button"><span>ㄲ</span></button></li><li><button type="button"><span>ㄳ</span></button></li><li><button type="button"><span>ㄴ</span></button></li><li><button type="button"><span>ㄵ</span></button></li><li><button type="button"><span>ㄶ</span></button></li><li><button type="button"><span>ㄷ</span></button></li><li><button type="button"><span>ㄸ</span></button></li><li><button type="button"><span>ㄹ</span></button></li><li><button type="button"><span>ㄺ</span></button></li><li><button type="button"><span>ㄻ</span></button></li><li><button type="button"><span>ㄼ</span></button></li><li><button type="button"><span>ㄽ</span></button></li><li><button type="button"><span>ㄾ</span></button></li><li><button type="button"><span>ㄿ</span></button></li><li><button type="button"><span>ㅀ</span></button></li><li><button type="button"><span>ㅁ</span></button></li><li><button type="button"><span>ㅂ</span></button></li><li><button type="button"><span>ㅃ</span></button></li><li><button type="button"><span>ㅄ</span></button></li><li><button type="button"><span>ㅅ</span></button></li><li><button type="button"><span>ㅆ</span></button></li><li><button type="button"><span>ㅇ</span></button></li><li><button type="button"><span>ㅈ</span></button></li><li><button type="button"><span>ㅉ</span></button></li><li><button type="button"><span>ㅊ</span></button></li><li><button type="button"><span>ㅋ</span></button></li><li><button type="button"><span>ㅌ</span></button></li><li><button type="button"><span>ㅍ</span></button></li><li><button type="button"><span>ㅎ</span></button></li><li><button type="button"><span>ㅏ</span></button></li><li><button type="button"><span>ㅐ</span></button></li><li><button type="button"><span>ㅑ</span></button></li><li><button type="button"><span>ㅒ</span></button></li><li><button type="button"><span>ㅓ</span></button></li><li><button type="button"><span>ㅔ</span></button></li><li><button type="button"><span>ㅕ</span></button></li><li><button type="button"><span>ㅖ</span></button></li><li><button type="button"><span>ㅗ</span></button></li><li><button type="button"><span>ㅘ</span></button></li><li><button type="button"><span>ㅙ</span></button></li><li><button type="button"><span>ㅚ</span></button></li><li><button type="button"><span>ㅛ</span></button></li><li><button type="button"><span>ㅜ</span></button></li><li><button type="button"><span>ㅝ</span></button></li><li><button type="button"><span>ㅞ</span></button></li><li><button type="button"><span>ㅟ</span></button></li><li><button type="button"><span>ㅠ</span></button></li><li><button type="button"><span>ㅡ</span></button></li><li><button type="button"><span>ㅢ</span></button></li><li><button type="button"><span>ㅣ</span></button></li><li><button type="button"><span>ㅥ</span></button></li><li><button type="button"><span>ㅦ</span></button></li><li><button type="button"><span>ㅧ</span></button></li><li><button type="button"><span>ㅨ</span></button></li><li><button type="button"><span>ㅩ</span></button></li><li><button type="button"><span>ㅪ</span></button></li><li><button type="button"><span>ㅫ</span></button></li><li><button type="button"><span>ㅬ</span></button></li><li><button type="button"><span>ㅭ</span></button></li><li><button type="button"><span>ㅮ</span></button></li><li><button type="button"><span>ㅯ</span></button></li><li><button type="button"><span>ㅰ</span></button></li><li><button type="button"><span>ㅱ</span></button></li><li><button type="button"><span>ㅲ</span></button></li><li><button type="button"><span>ㅳ</span></button></li><li><button type="button"><span>ㅴ</span></button></li><li><button type="button"><span>ㅵ</span></button></li><li><button type="button"><span>ㅶ</span></button></li><li><button type="button"><span>ㅷ</span></button></li><li><button type="button"><span>ㅸ</span></button></li><li><button type="button"><span>ㅹ</span></button></li><li><button type="button"><span>ㅺ</span></button></li><li><button type="button"><span>ㅻ</span></button></li><li><button type="button"><span>ㅼ</span></button></li><li><button type="button"><span>ㅽ</span></button></li><li><button type="button"><span>ㅾ</span></button></li><li><button type="button"><span>ㅿ</span></button></li><li><button type="button"><span>ㆀ</span></button></li><li><button type="button"><span>ㆁ</span></button></li><li><button type="button"><span>ㆂ</span></button></li><li><button type="button"><span>ㆃ</span></button></li><li><button type="button"><span>ㆄ</span></button></li><li><button type="button"><span>ㆅ</span></button></li><li><button type="button"><span>ㆆ</span></button></li><li><button type="button"><span>ㆇ</span></button></li><li><button type="button"><span>ㆈ</span></button></li><li><button type="button"><span>ㆉ</span></button></li><li><button type="button"><span>ㆊ</span></button></li><li><button type="button"><span>ㆋ</span></button></li><li><button type="button"><span>ㆌ</span></button></li><li><button type="button"><span>ㆍ</span></button></li><li><button type="button"><span>ㆎ</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="ギリシャ,ラテン語" class="se2_char5"><span>ギリシャ,ラテン語</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- 그리스,라틴어 목록 -->
											<!-- <li><button type="button"><span>Α</span></button></li><li><button type="button"><span>Β</span></button></li><li><button type="button"><span>Γ</span></button></li><li><button type="button"><span>Δ</span></button></li><li><button type="button"><span>Ε</span></button></li><li><button type="button"><span>Ζ</span></button></li><li><button type="button"><span>Η</span></button></li><li><button type="button"><span>Θ</span></button></li><li><button type="button"><span>Ι</span></button></li><li><button type="button"><span>Κ</span></button></li><li><button type="button"><span>Λ</span></button></li><li><button type="button"><span>Μ</span></button></li><li><button type="button"><span>Ν</span></button></li><li><button type="button"><span>Ξ</span></button></li><li class="hover"><button type="button"><span>Ο</span></button></li><li><button type="button"><span>Π</span></button></li><li><button type="button"><span>Ρ</span></button></li><li><button type="button"><span>Σ</span></button></li><li><button type="button"><span>Τ</span></button></li><li><button type="button"><span>Υ</span></button></li><li><button type="button"><span>Φ</span></button></li><li><button type="button"><span>Χ</span></button></li><li><button type="button"><span>Ψ</span></button></li><li><button type="button"><span>Ω</span></button></li><li><button type="button"><span>α</span></button></li><li><button type="button"><span>β</span></button></li><li><button type="button"><span>γ</span></button></li><li><button type="button"><span>δ</span></button></li><li><button type="button"><span>ε</span></button></li><li><button type="button"><span>ζ</span></button></li><li><button type="button"><span>η</span></button></li><li><button type="button"><span>θ</span></button></li><li><button type="button"><span>ι</span></button></li><li><button type="button"><span>κ</span></button></li><li><button type="button"><span>λ</span></button></li><li><button type="button"><span>μ</span></button></li><li><button type="button"><span>ν</span></button></li><li><button type="button"><span>ξ</span></button></li><li><button type="button"><span>ο</span></button></li><li><button type="button"><span>π</span></button></li><li><button type="button"><span>ρ</span></button></li><li><button type="button"><span>σ</span></button></li><li><button type="button"><span>τ</span></button></li><li><button type="button"><span>υ</span></button></li><li><button type="button"><span>φ</span></button></li><li><button type="button"><span>χ</span></button></li><li><button type="button"><span>ψ</span></button></li><li><button type="button"><span>ω</span></button></li><li><button type="button"><span>Æ</span></button></li><li><button type="button"><span>Ð</span></button></li><li><button type="button"><span>Ħ</span></button></li><li><button type="button"><span>Ĳ</span></button></li><li><button type="button"><span>Ŀ</span></button></li><li><button type="button"><span>Ł</span></button></li><li><button type="button"><span>Ø</span></button></li><li><button type="button"><span>Œ</span></button></li><li><button type="button"><span>Þ</span></button></li><li><button type="button"><span>Ŧ</span></button></li><li><button type="button"><span>Ŋ</span></button></li><li><button type="button"><span>æ</span></button></li><li><button type="button"><span>đ</span></button></li><li><button type="button"><span>ð</span></button></li><li><button type="button"><span>ħ</span></button></li><li><button type="button"><span>I</span></button></li><li><button type="button"><span>ĳ</span></button></li><li><button type="button"><span>ĸ</span></button></li><li><button type="button"><span>ŀ</span></button></li><li><button type="button"><span>ł</span></button></li><li><button type="button"><span>ł</span></button></li><li><button type="button"><span>œ</span></button></li><li><button type="button"><span>ß</span></button></li><li><button type="button"><span>þ</span></button></li><li><button type="button"><span>ŧ</span></button></li><li><button type="button"><span>ŋ</span></button></li><li><button type="button"><span>ŉ</span></button></li><li><button type="button"><span>Б</span></button></li><li><button type="button"><span>Г</span></button></li><li><button type="button"><span>Д</span></button></li><li><button type="button"><span>Ё</span></button></li><li><button type="button"><span>Ж</span></button></li><li><button type="button"><span>З</span></button></li><li><button type="button"><span>И</span></button></li><li><button type="button"><span>Й</span></button></li><li><button type="button"><span>Л</span></button></li><li><button type="button"><span>П</span></button></li><li><button type="button"><span>Ц</span></button></li><li><button type="button"><span>Ч</span></button></li><li><button type="button"><span>Ш</span></button></li><li><button type="button"><span>Щ</span></button></li><li><button type="button"><span>Ъ</span></button></li><li><button type="button"><span>Ы</span></button></li><li><button type="button"><span>Ь</span></button></li><li><button type="button"><span>Э</span></button></li><li><button type="button"><span>Ю</span></button></li><li><button type="button"><span>Я</span></button></li><li><button type="button"><span>б</span></button></li><li><button type="button"><span>в</span></button></li><li><button type="button"><span>г</span></button></li><li><button type="button"><span>д</span></button></li><li><button type="button"><span>ё</span></button></li><li><button type="button"><span>ж</span></button></li><li><button type="button"><span>з</span></button></li><li><button type="button"><span>и</span></button></li><li><button type="button"><span>й</span></button></li><li><button type="button"><span>л</span></button></li><li><button type="button"><span>п</span></button></li><li><button type="button"><span>ф</span></button></li><li><button type="button"><span>ц</span></button></li><li><button type="button"><span>ч</span></button></li><li><button type="button"><span>ш</span></button></li><li><button type="button"><span>щ</span></button></li><li><button type="button"><span>ъ</span></button></li><li><button type="button"><span>ы</span></button></li><li><button type="button"><span>ь</span></button></li><li><button type="button"><span>э</span></button></li><li><button type="button"><span>ю</span></button></li><li><button type="button"><span>я</span></button></li> -->
										</ul>
									</div>
								</li>
								<li><button type="button" title="日本語" class="se2_char6"><span>日本語</span></button>
									<div class="se2_s_character">
										<ul class="husky_se2m_sCharacter_list">
											<li></li>
											<!-- 일본어 목록 -->
											<!-- <li><button type="button"><span>ぁ</span></button></li><li class="hover"><button type="button"><span>あ</span></button></li><li><button type="button"><span>ぃ</span></button></li><li><button type="button"><span>い</span></button></li><li><button type="button"><span>ぅ</span></button></li><li><button type="button"><span>う</span></button></li><li><button type="button"><span>ぇ</span></button></li><li><button type="button"><span>え</span></button></li><li><button type="button"><span>ぉ</span></button></li><li><button type="button"><span>お</span></button></li><li><button type="button"><span>か</span></button></li><li><button type="button"><span>が</span></button></li><li><button type="button"><span>き</span></button></li><li><button type="button"><span>ぎ</span></button></li><li><button type="button"><span>く</span></button></li><li><button type="button"><span>ぐ</span></button></li><li><button type="button"><span>け</span></button></li><li><button type="button"><span>げ</span></button></li><li><button type="button"><span>こ</span></button></li><li><button type="button"><span>ご</span></button></li><li><button type="button"><span>さ</span></button></li><li><button type="button"><span>ざ</span></button></li><li><button type="button"><span>し</span></button></li><li><button type="button"><span>じ</span></button></li><li><button type="button"><span>す</span></button></li><li><button type="button"><span>ず</span></button></li><li><button type="button"><span>せ</span></button></li><li><button type="button"><span>ぜ</span></button></li><li><button type="button"><span>そ</span></button></li><li><button type="button"><span>ぞ</span></button></li><li><button type="button"><span>た</span></button></li><li><button type="button"><span>だ</span></button></li><li><button type="button"><span>ち</span></button></li><li><button type="button"><span>ぢ</span></button></li><li><button type="button"><span>っ</span></button></li><li><button type="button"><span>つ</span></button></li><li><button type="button"><span>づ</span></button></li><li><button type="button"><span>て</span></button></li><li><button type="button"><span>で</span></button></li><li><button type="button"><span>と</span></button></li><li><button type="button"><span>ど</span></button></li><li><button type="button"><span>な</span></button></li><li><button type="button"><span>に</span></button></li><li><button type="button"><span>ぬ</span></button></li><li><button type="button"><span>ね</span></button></li><li><button type="button"><span>の</span></button></li><li><button type="button"><span>は</span></button></li><li><button type="button"><span>ば</span></button></li><li><button type="button"><span>ぱ</span></button></li><li><button type="button"><span>ひ</span></button></li><li><button type="button"><span>び</span></button></li><li><button type="button"><span>ぴ</span></button></li><li><button type="button"><span>ふ</span></button></li><li><button type="button"><span>ぶ</span></button></li><li><button type="button"><span>ぷ</span></button></li><li><button type="button"><span>へ</span></button></li><li><button type="button"><span>べ</span></button></li><li><button type="button"><span>ぺ</span></button></li><li><button type="button"><span>ほ</span></button></li><li><button type="button"><span>ぼ</span></button></li><li><button type="button"><span>ぽ</span></button></li><li><button type="button"><span>ま</span></button></li><li><button type="button"><span>み</span></button></li><li><button type="button"><span>む</span></button></li><li><button type="button"><span>め</span></button></li><li><button type="button"><span>も</span></button></li><li><button type="button"><span>ゃ</span></button></li><li><button type="button"><span>や</span></button></li><li><button type="button"><span>ゅ</span></button></li><li><button type="button"><span>ゆ</span></button></li><li><button type="button"><span>ょ</span></button></li><li><button type="button"><span>よ</span></button></li><li><button type="button"><span>ら</span></button></li><li><button type="button"><span>り</span></button></li><li><button type="button"><span>る</span></button></li><li><button type="button"><span>れ</span></button></li><li><button type="button"><span>ろ</span></button></li><li><button type="button"><span>ゎ</span></button></li><li><button type="button"><span>わ</span></button></li><li><button type="button"><span>ゐ</span></button></li><li><button type="button"><span>ゑ</span></button></li><li><button type="button"><span>を</span></button></li><li><button type="button"><span>ん</span></button></li><li><button type="button"><span>ァ</span></button></li><li><button type="button"><span>ア</span></button></li><li><button type="button"><span>ィ</span></button></li><li><button type="button"><span>イ</span></button></li><li><button type="button"><span>ゥ</span></button></li><li><button type="button"><span>ウ</span></button></li><li><button type="button"><span>ェ</span></button></li><li><button type="button"><span>エ</span></button></li><li><button type="button"><span>ォ</span></button></li><li><button type="button"><span>オ</span></button></li><li><button type="button"><span>カ</span></button></li><li><button type="button"><span>ガ</span></button></li><li><button type="button"><span>キ</span></button></li><li><button type="button"><span>ギ</span></button></li><li><button type="button"><span>ク</span></button></li><li><button type="button"><span>グ</span></button></li><li><button type="button"><span>ケ</span></button></li><li><button type="button"><span>ゲ</span></button></li><li><button type="button"><span>コ</span></button></li><li><button type="button"><span>ゴ</span></button></li><li><button type="button"><span>サ</span></button></li><li><button type="button"><span>ザ</span></button></li><li><button type="button"><span>シ</span></button></li><li><button type="button"><span>ジ</span></button></li><li><button type="button"><span>ス</span></button></li><li><button type="button"><span>ズ</span></button></li><li><button type="button"><span>セ</span></button></li><li><button type="button"><span>ゼ</span></button></li><li><button type="button"><span>ソ</span></button></li><li><button type="button"><span>ゾ</span></button></li><li><button type="button"><span>タ</span></button></li><li><button type="button"><span>ダ</span></button></li><li><button type="button"><span>チ</span></button></li><li><button type="button"><span>ヂ</span></button></li><li><button type="button"><span>ッ</span></button></li><li><button type="button"><span>ツ</span></button></li><li><button type="button"><span>ヅ</span></button></li><li><button type="button"><span>テ</span></button></li><li><button type="button"><span>デ</span></button></li><li><button type="button"><span>ト</span></button></li><li><button type="button"><span>ド</span></button></li><li><button type="button"><span>ナ</span></button></li><li><button type="button"><span>ニ</span></button></li><li><button type="button"><span>ヌ</span></button></li><li><button type="button"><span>ネ</span></button></li><li><button type="button"><span>ノ</span></button></li><li><button type="button"><span>ハ</span></button></li><li><button type="button"><span>バ</span></button></li><li><button type="button"><span>パ</span></button></li><li><button type="button"><span>ヒ</span></button></li><li><button type="button"><span>ビ</span></button></li><li><button type="button"><span>ピ</span></button></li><li><button type="button"><span>フ</span></button></li><li><button type="button"><span>ブ</span></button></li><li><button type="button"><span>プ</span></button></li><li><button type="button"><span>ヘ</span></button></li><li><button type="button"><span>ベ</span></button></li><li><button type="button"><span>ペ</span></button></li><li><button type="button"><span>ホ</span></button></li><li><button type="button"><span>ボ</span></button></li><li><button type="button"><span>ポ</span></button></li><li><button type="button"><span>マ</span></button></li><li><button type="button"><span>ミ</span></button></li><li><button type="button"><span>ム</span></button></li><li><button type="button"><span>メ</span></button></li><li><button type="button"><span>モ</span></button></li><li><button type="button"><span>ャ</span></button></li><li><button type="button"><span>ヤ</span></button></li><li><button type="button"><span>ュ</span></button></li><li><button type="button"><span>ユ</span></button></li><li><button type="button"><span>ョ</span></button></li><li><button type="button"><span>ヨ</span></button></li><li><button type="button"><span>ラ</span></button></li><li><button type="button"><span>リ</span></button></li><li><button type="button"><span>ル</span></button></li><li><button type="button"><span>レ</span></button></li><li><button type="button"><span>ロ</span></button></li><li><button type="button"><span>ヮ</span></button></li><li><button type="button"><span>ワ</span></button></li><li><button type="button"><span>ヰ</span></button></li><li><button type="button"><span>ヱ</span></button></li><li><button type="button"><span>ヲ</span></button></li><li><button type="button"><span>ン</span></button></li><li><button type="button"><span>ヴ</span></button></li><li><button type="button"><span>ヵ</span></button></li><li><button type="button"><span>ヶ</span></button></li> -->
										</ul>
									</div>
								</li>
								</ul>
								<p class="se2_apply_character">
									<label for="char_preview">選択した記号</label> <input type="text" name="char_preview" id="char_preview" value="®º⊆●○" class="input_ty1"><button type="button" class="se2_confirm"><span>適用</span></button><button type="button" class="se2_cancel husky_se2m_sCharacter_close"><span>キャンセル</span></button>
								</p>
							</div>
						</div>
					</div>
					<!-- //특수기호 -->
				</li>

				<li class="husky_seditor_ui_table"><button type="button" title="表" class="se2_table"><span class="_buttonRound">表</span></button>
					<!--@lazyload_html create_table-->
					<!-- 표 -->
					<div class="se2_layer husky_se2m_table_layer" style="margin-left:-171px">
						<div class="se2_in_layer">
							<div class="se2_table_set">
								<fieldset>
								<legend>列の数を指定</legend>
									<dl class="se2_cell_num">
									<dt><label for="row">行</label></dt>
									<dd><input id="row" name="" type="text" maxlength="2" value="4" class="input_ty2">
										<button type="button" class="se2_add"><span>1行追加</span></button>
										<button type="button" class="se2_del"><span>1行削除<</span></button>
									</dd>
									<dt><label for="col">列</label></dt>
									<dd><input id="col" name="" type="text" maxlength="2" value="4" class="input_ty2">
										<button type="button" class="se2_add"><span>1列追加</span></button>
										<button type="button" class="se2_del"><span>1列削除</span></button>
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
									<legend>促成を直接入力</legend>
									<dl class="se2_t_proper1">
									<dt><input type="radio" id="se2_tbp1" name="se2_tbp" checked><label for="se2_tbp1">促成を直接入力</label></dt>
									<dd>
										<dl class="se2_t_proper1_1">
										<dt><label>表スタイル</label></dt>
										<dd><div class="se2_select_ty1"><span class="se2_b_style3 husky_se2m_table_border_style_preview"></span><button type="button" title="もっと見る" class="se2_view_more"><span>もっと見る</span></button></div>
											<!-- 레이어 : 테두리스타일 -->
											<div class="se2_layer_b_style husky_se2m_table_border_style_layer" style="display:none">
												<ul>
												<li><button type="button" class="se2_b_style1"><span class="se2m_no_border">枠なし</span></button></li>
												<li><button type="button" class="se2_b_style2"><span><span>枠のスタイル2</span></span></button></li>
												<li><button type="button" class="se2_b_style3"><span><span>枠のスタイル3</span></span></button></li>
												<li><button type="button" class="se2_b_style4"><span><span>枠のスタイル4</span></span></button></li>
												<li><button type="button" class="se2_b_style5"><span><span>枠のスタイル5</span></span></button></li>
												<li><button type="button" class="se2_b_style6"><span><span>枠のスタイル6</span></span></button></li>
												<li><button type="button" class="se2_b_style7"><span><span>枠のスタイル7</span></span></button></li>
												</ul>
											</div>
											<!-- //레이어 : 테두리스타일 -->
										</dd>
										</dl>
										<dl class="se2_t_proper1_1 se2_t_proper1_2">
										<dt><label for="se2_b_width">枠の太さ</label></dt>
										<dd><input id="se2_b_width" name="" type="text" maxlength="2" value="1" class="input_ty1">
											<button type="button" title="1px 足す" class="se2_add se2m_incBorder"><span>1px 足す</span></button>
											<button type="button" title="1px 引く" class="se2_del se2m_decBorder"><span>1px 引く</span></button>
										</dd>
										</dl>
										<dl class="se2_t_proper1_1 se2_t_proper1_3">
										<dt><label for="se2_b_color">枠の色</label></dt>
										<dd><input id="se2_b_color" name="" type="text" maxlength="7" value="#cccccc" class="input_ty3"><span class="se2_pre_color"><button type="button" style="background:#cccccc;"><span>色を選択</span></button></span>	
										<!-- 레이어 : 테두리색 -->
											<div class="se2_layer se2_b_t_b1" style="clear:both;display:none;position:absolute;top:20px;left:-147px;">
												<div class="se2_in_layer husky_se2m_table_border_color_pallet">
												</div>
											</div>
										<!-- //레이어 : 테두리색-->
										</dd>
										</dl>
										<div class="se2_t_dim0"></div><!-- 테두리 없음일때 딤드레이어 -->
										<dl class="se2_t_proper1_1 se2_t_proper1_4">
										<dt><label for="se2_cellbg">セルの背景色</label></dt>
										<dd><input id="se2_cellbg" name="" type="text" maxlength="7" value="#ffffff" class="input_ty3"><span class="se2_pre_color"><button type="button" style="background:#ffffff;"><span>色を検索</span></button></span>
										<!-- 레이어 : 셀배경색 -->
										<div class="se2_layer se2_b_t_b1" style="clear:both;display:none;position:absolute;top:20px;left:-147px;">
											<div class="se2_in_layer husky_se2m_table_bgcolor_pallet">
											</div>
										</div>
										<!-- //레이어 : 셀배경색-->
										</dd>
										</dl>
									</dd>
									</dl>
								</fieldset>
								<fieldset>
									<legend>表スタイル</legend>
									<dl class="se2_t_proper2">
									<dt><input type="radio" id="se2_tbp2" name="se2_tbp"><label for="se2_tbp2">スタイルを選択</label></dt>
									<dd><div class="se2_select_ty2"><span class="se2_t_style1 husky_se2m_table_style_preview"></span><button type="button" title="もっと見る" class="se2_view_more"><span>もっと見る</span></button></div>
										<!-- 레이어 : 표템플릿선택 -->
										<div class="se2_layer_t_style husky_se2m_table_style_layer" style="display:none">
											<ul class="se2_scroll">
											<li><button type="button" class="se2_t_style1"><span>表スタイル1</span></button></li>
											<li><button type="button" class="se2_t_style2"><span>表スタイル2</span></button></li>
											<li><button type="button" class="se2_t_style3"><span>表スタイル3</span></button></li>
											<li><button type="button" class="se2_t_style4"><span>表スタイル4</span></button></li>
											<li><button type="button" class="se2_t_style5"><span>表スタイル5</span></button></li>
											<li><button type="button" class="se2_t_style6"><span>表スタイル6</span></button></li>
											<li><button type="button" class="se2_t_style7"><span>表スタイル7</span></button></li>
											<li><button type="button" class="se2_t_style8"><span>表スタイル8</span></button></li>
											<li><button type="button" class="se2_t_style9"><span>表スタイル9</span></button></li>
											<li><button type="button" class="se2_t_style10"><span>表スタイル10</span></button></li>
											<li><button type="button" class="se2_t_style11"><span>表スタイル11</span></button></li>
											<li><button type="button" class="se2_t_style12"><span>表スタイル12</span></button></li>
											<li><button type="button" class="se2_t_style13"><span>表スタイル13</span></button></li>
											<li><button type="button" class="se2_t_style14"><span>表スタイル14</span></button></li>
											<li><button type="button" class="se2_t_style15"><span>表スタイル15</span></button></li>
											<li><button type="button" class="se2_t_style16"><span>表スタイル16</span></button></li>
											</ul>
										</div>
										<!-- //레이어 : 표템플릿선택 -->
									</dd>
									</dl>
								</fieldset>
								<p class="se2_btn_area">
									<button type="button" class="se2_apply"><span>適用</span></button><button type="button" class="se2_cancel"><span>キャンセル</span></button>
								</p>
								<!-- 딤드레이어 -->
								<div class="se2_t_dim3"></div>
								<!-- //딤드레이어 -->
							</div>
						</div>
					</div>
					<!-- //표 -->
					<!--//@lazyload_html-->
				</li>
				<li class="image husky_seditor_ui_image" style="display:none;">
					<button type="button" title="イメージ挿入" class="se2_image"><span>イメージ挿入</span></button>
					<!-- 이미지 삽입 레이어 -->
					<div class="layer husky_seditor_image_layer" style="margin-left:-238px;display:none;">
						<h3>イメージ挿入</h3>
						<button type="button" class="close" title="イメージ挿入レイヤーを閉じる"><span>イメージ挿入レイヤーを閉じる</span></button>
						<div class="upload_area">
							<span class="help_text"></span>
							<span class="upload_btn" id="upload_btn" title="ファイル追加"></span>
						</div>
						<div class="statusDefault">
			            	<p class="expdefault">클릭 혹은 파일 끌어다 넣기</p>
			            </div>
			            <div class="statusOn">
			                <a class="iconAdd"></a>
			                <a class="explain_mouseOn">이미지 추가</a>
			            </div>
			            <div class="statusDrag"></div>
						<div class="list_area">
							<ul class="file_list"></ul>
						</div>
						<div class="btn_area">
							<button type="button" class="confirm" title="確認"><span>確認</span></button>
							<button type="button" class="cancel" title="キャンセル"><span>キャンセル</span></button>
						</div>
					</div>
					<!-- /이미지 삽입 레이어 -->
				</li>
				<li class="movie husky_seditor_ui_movie" style="display:none;"><button type="button" title="ムービー挿入" class="se2_movie"><span>ムービー挿入</span></button></li>
				<li class="husky_seditor_ui_findAndReplace last_child"><button type="button" title="検索/置き換え" class="se2_find"><span class="_buttonRound tool_bg">検索/置き換え</span></button>
					<!--@lazyload_html find_and_replace-->
					<!-- 찾기/바꾸기 -->
					<div class="se2_layer husky_se2m_findAndReplace_layer" style="margin-left:-238px;">
						<div class="se2_in_layer">
							<div class="se2_bx_find_revise">
								<button type="button" title="閉じる" class="se2_close husky_se2m_cancel"><span>閉じる</span></button>
								<h3>検索/置き換え</h3>
								<ul>
								<li class="active"><button type="button" class="se2_tabfind"><span>検索</span></button></li>
								<li><button type="button" class="se2_tabrevise"><span>置き換え</span></button></li>
								</ul>
								<div class="se2_in_bx_find husky_se2m_find_ui" style="display:block">
									<dl>
									<dt><label for="find_word">探す単語</label></dt><dd><input type="text" id="find_word" value="スマートエディター" class="input_ty1"></dd>
									</dl>
									<p class="se2_find_btns">
										<button type="button" class="se2_find_next husky_se2m_find_next"><span>次を検索<</span></button><button type="button" class="se2_cancel husky_se2m_cancel"><span>キャンセル</span></button>
									</p>
								</div>
								<div class="se2_in_bx_revise husky_se2m_replace_ui" style="display:none">
									<dl>
									<dt><label for="find_word2">探す単語</label></dt><dd><input type="text" id="find_word2" value="スマートエディター" class="input_ty1"></dd>
									<dt><label for="revise_word">置き換える単語</label></dt><dd><input type="text" id="revise_word" value="スマートエディター" class="input_ty1"></dd>
									</dl>
									<p class="se2_find_btns">
										<button type="button" class="se2_find_next2 husky_se2m_replace_find_next"><span>次を検索</span></button><button type="button" class="se2_revise1 husky_se2m_replace"><span>置き換える</span></button><button type="button" class="se2_revise2 husky_se2m_replace_all"><span>全てを置き換える</span></button><button type="button" class="se2_cancel husky_se2m_cancel"><span>キャンセル</span></button>
									</p>
								</div>
								<button type="button" title="閉じる" class="se2_close husky_se2m_cancel"><span>閉じる</span></button>
							</div>
						</div>
					</div>
					<!-- //찾기/바꾸기 -->
					<!--//@lazyload_html-->
				</li>
</ul>
			</div>
			<!-- //704이상 -->
		</div>
		
				<!-- 접근성 도움말 레이어 -->
		<div class="se2_layer se2_accessibility" style="display:none;">
			<div class="se2_in_layer">
				<button type="button" title="閉じる" class="se2_close"><span>閉じる</span></button>
				<h3><strong>アクセシビリティヘルプ</strong></h3>
				<div class="box_help">
					<div>
						<strong>ツールバー</strong>
						<p>ALT+F10を押せばツールバーに移動します。次のボタンはTABで、前のボタンはSHIFT+TABで移動できます。 ENTERを押せば該当ボタンの機能が動作して、入力領域にフォーカスが移動します。ESCを押せば何も起きず、入力領域にフォーカスが移動します。</p>
						<strong>出る</strong>
						<p>ALT+. を押せばスマートエディターの次の要素で ALT+, を押せばスマートエディター前の要素に戻ることができます。</p>
						<strong>命令語短縮キー</strong>
						<ul>
						<li>CTRL+B <span>太字</span></li>
						<li>SHIFT+TAB <span>逆インデント</span></li>
						<li>CTRL+U <span>下線</span></li>
						<li>CTRL+F <span>検索</span></li>
						<li>CTRL+I <span>斜体</span></li>
						<li>CTRL+H <span>置き換え</span></li>
						<li>CTRL+D <span>取り消し線</span></li>
						<li>CTRL+K <span>リンク</span></li>
						<li>TAB <span>インデント</span></li>
						</ul>
					</div>
				</div>
				<div class="se2_btns">
					<button type="button" class="se2_close2"><span>閉じる</span></button>
				</div>
			</div>
		</div>		
		<!-- //접근성 도움말 레이어 -->

		<hr>
		<!-- 입력 -->
		<div class="se2_input_area husky_seditor_editing_area_container">
			
			
			<iframe src="about:blank" id="se2_iframe" name="se2_iframe" class="se2_input_wysiwyg" width="400" height="300" title="入力領域 : ツール集めはALT+F10を, ヘルプは ALT+0を押してください。" frameborder="0" style="display:block;"></iframe>
			<textarea name="" rows="10" cols="100" title="HTML編集" class="se2_input_syntax se2_input_htmlsrc" style="display:none;outline-style:none;resize:none"> </textarea>
			<textarea name="" rows="10" cols="100" title="TEXT編集" class="se2_input_syntax se2_input_text" style="display:none;outline-style:none;resize:none;"> </textarea>
			
			<!-- 입력창 조절 안내 레이어 -->
			<div class="ly_controller husky_seditor_resize_notice" style="z-index:20;display:none;">
				<p>下の領域をドラッグして入力欄のサイズを調節できます。</p>
				<button type="button" title="閉じる" class="bt_clse"><span>閉じる</span></button>
				<span class="ic_arr"></span>
			</div>
			<!-- //입력창 조절 안내 레이어 -->
						<div class="quick_wrap">
				<!-- 표/글양식 간단편집기 -->
				<!--@lazyload_html qe_table-->
				<div class="q_table_wrap" style="z-index: 150;">
				<button class="_fold se2_qmax q_open_table_full" style="position:absolute; display:none;top:340px;left:210px;z-index:30;" title="最大化" type="button"><span>クイックエディターの最大化</span></button>
				<div class="_full se2_qeditor se2_table_set" style="position:absolute;display:none;top:135px;left:661px;z-index:30;">
					<div class="se2_qbar q_dragable"><span class="se2_qmini"><button title="最小化" class="q_open_table_fold"><span>クイックエディターの最小化</span></button></span></div>
					<div class="se2_qbody0">
						<div class="se2_qbody">
							<dl class="se2_qe1">
							<dt>挿入</dt><dd><button class="se2_addrow" title="行挿入" type="button"><span>行挿入</span></button><button class="se2_addcol" title="列挿入" type="button"><span>列挿入</span></button></dd>
							<dt>分割</dt><dd><button class="se2_seprow" title="行分割" type="button"><span>行分割</span></button><button class="se2_sepcol" title="列分割" type="button"><span>列分割</span></button></dd>

							<dt>削除</dt><dd><button class="se2_delrow" title="行削除" type="button"><span>行削除</span></button><button class="se2_delcol" title="列削除" type="button"><span>列削除</span></button></dd>
							<dt>併合</dt><dd><button class="se2_merrow" title="行併合" type="button"><span>行併合</span></button></dd>
							</dl>
							<div class="se2_qe2 se2_qe2_3"> <!-- 테이블 퀵에디터의 경우만,  se2_qe2_3제거 -->
								<!-- 샐배경색 -->
								<dl class="se2_qe2_1">

								<dt><input type="radio" checked="checked" name="se2_tbp3" id="se2_cellbg2" class="husky_se2m_radio_bgc"><label for="se2_cellbg2">セルの背景色</label></dt>
								<dd><span class="se2_pre_color"><button style="background: none repeat scroll 0% 0% rgb(255, 255, 255);" type="button" class="husky_se2m_table_qe_bgcolor_btn"><span>色を選択</span></button></span>		
									<!-- layer:셀배경색 -->
									<div style="display:none;position:absolute;top:20px;left:0px;" class="se2_layer se2_b_t_b1">
										<div class="se2_in_layer husky_se2m_tbl_qe_bg_paletteHolder">
										</div>
									</div>
									<!-- //layer:셀배경색-->

								</dd>
								</dl>
								<!-- //샐배경색 -->
								<!-- 배경이미지선택 -->
								<dl style="display: none;" class="se2_qe2_2 husky_se2m_tbl_qe_review_bg">
								<dt><input type="radio" name="se2_tbp3" id="se2_cellbg3" class="husky_se2m_radio_bgimg"><label for="se2_cellbg3">イメージ</label></dt>
								<dd><span class="se2_pre_bgimg"><button class="husky_se2m_table_qe_bgimage_btn se2_cellimg0" type="button"><span>背景イメージ選択</span></button></span>
									<!-- layer:배경이미지선택 -->
									<div style="display:none;position:absolute;top:20px;left:-155px;" class="se2_layer se2_b_t_b1">
										<div class="se2_in_layer husky_se2m_tbl_qe_bg_img_paletteHolder">
											<ul class="se2_cellimg_set">
											<li><button class="se2_cellimg0" type="button"><span>背景なし</span></button></li>
											<li><button class="se2_cellimg1" type="button"><span>背景1</span></button></li>
											<li><button class="se2_cellimg2" type="button"><span>背景2</span></button></li>
											<li><button class="se2_cellimg3" type="button"><span>背景3</span></button></li>
											<li><button class="se2_cellimg4" type="button"><span>背景4</span></button></li>
											<li><button class="se2_cellimg5" type="button"><span>背景5</span></button></li>
											<li><button class="se2_cellimg6" type="button"><span>背景6</span></button></li>
											<li><button class="se2_cellimg7" type="button"><span>背景7</span></button></li>
											<li><button class="se2_cellimg8" type="button"><span>背景8</span></button></li>
											<li><button class="se2_cellimg9" type="button"><span>背景9</span></button></li>
											<li><button class="se2_cellimg10" type="button"><span>背景10</span></button></li>
											<li><button class="se2_cellimg11" type="button"><span>背景11</span></button></li>
											<li><button class="se2_cellimg12" type="button"><span>背景12</span></button></li>
											<li><button class="se2_cellimg13" type="button"><span>背景13</span></button></li>
											<li><button class="se2_cellimg14" type="button"><span>背景14</span></button></li>
											<li><button class="se2_cellimg15" type="button"><span>背景15</span></button></li>
											<li><button class="se2_cellimg16" type="button"><span>背景16</span></button></li>
											<li><button class="se2_cellimg17" type="button"><span>背景17</span></button></li>
											<li><button class="se2_cellimg18" type="button"><span>背景18</span></button></li>
											<li><button class="se2_cellimg19" type="button"><span>背景19</span></button></li>
											<li><button class="se2_cellimg20" type="button"><span>背景20</span></button></li>
											<li><button class="se2_cellimg21" type="button"><span>背景21</span></button></li>
											<li><button class="se2_cellimg22" type="button"><span>背景22</span></button></li>
											<li><button class="se2_cellimg23" type="button"><span>背景23</span></button></li>
											<li><button class="se2_cellimg24" type="button"><span>背景24</span></button></li>
											<li><button class="se2_cellimg25" type="button"><span>背景25</span></button></li>
											<li><button class="se2_cellimg26" type="button"><span>背景26</span></button></li>
											<li><button class="se2_cellimg27" type="button"><span>背景27</span></button></li>
											<li><button class="se2_cellimg28" type="button"><span>背景28</span></button></li>
											<li><button class="se2_cellimg29" type="button"><span>背景29</span></button></li>
											<li><button class="se2_cellimg30" type="button"><span>背景30</span></button></li>
											<li><button class="se2_cellimg31" type="button"><span>背景31</span></button></li>
											</ul>
										</div>
									</div>
									<!-- //layer:배경이미지선택-->
								</dd>
								</dl>
								<!-- //배경이미지선택 -->
							</div>
							<dl style="display: block;" class="se2_qe3 se2_t_proper2">
							<dt><input type="radio" name="se2_tbp3" id="se2_tbp4" class="husky_se2m_radio_template"><label for="se2_tbp4">表スタイル</label></dt>
							<dd>
								<div class="se2_qe3_table">
								<div class="se2_select_ty2"><span class="se2_t_style1"></span><button class="se2_view_more husky_se2m_template_more" title="もっと見る" type="button"><span>もっと見る</span></button></div>
								<!-- layer:표스타일 -->
								<div style="display:none;top:33px;left:0;margin:0;" class="se2_layer_t_style">
									<ul>
									<li><button class="se2_t_style1" type="button"><span>表スタイル1</span></button></li>
									<li><button class="se2_t_style2" type="button"><span>表スタイル2</span></button></li>
									<li><button class="se2_t_style3" type="button"><span>表スタイル3</span></button></li>
									<li><button class="se2_t_style4" type="button"><span>表スタイル4</span></button></li>
									<li><button class="se2_t_style5" type="button"><span>表スタイル5</span></button></li>
									<li><button class="se2_t_style6" type="button"><span>表スタイル6</span></button></li>
									<li><button class="se2_t_style7" type="button"><span>表スタイル7</span></button></li>
									<li><button class="se2_t_style8" type="button"><span>表スタイル8</span></button></li>
									<li><button class="se2_t_style9" type="button"><span>表スタイル9</span></button></li>
									<li><button class="se2_t_style10" type="button"><span>表スタイル10</span></button></li>
									<li><button class="se2_t_style11" type="button"><span>表スタイル11</span></button></li>
									<li><button class="se2_t_style12" type="button"><span>表スタイル12</span></button></li>
									<li><button class="se2_t_style13" type="button"><span>表スタイル13</span></button></li>
									<li><button class="se2_t_style14" type="button"><span>表スタイル14</span></button></li>
									<li><button class="se2_t_style15" type="button"><span>表スタイル15</span></button></li>
									<li><button class="se2_t_style16" type="button"><span>表スタイル16</span></button></li>
									</ul>
								</div>
								<!-- //layer:표스타일 -->
								</div>
							</dd>
							</dl>
							<div style="display:none" class="se2_btn_area">
								<button class="se2_btn_save" type="button"><span>マイレビューの保存</span></button>
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
				<!-- //표/글양식 간단편집기 -->
				<!-- 이미지 간단편집기 -->
				<!--@lazyload_html qe_image-->
				<div class="q_img_wrap">
					<button class="_fold se2_qmax q_open_img_full" style="position:absolute;display:none;top:240px;left:210px;z-index:30;" title="最大化" type="button"><span>クイックエディターの最大化</span></button>
					<div class="_full_1 se2_qeditor se2_table_set" style="position:absolute;display:none;top:50%;left:50%;z-index:30;">
						<div class="se2_qbar  q_dragable"></div>
						<div class="se2_qbody0">
							<div class="se2_qbody">
								<div class="se2_qe10">
									<label for="se2_swidth">横</label><input type="text" class="input_ty1 widthimg" name="" id="se2_swidth" value="1024"><label class="se2_sheight" for="se2_sheight">縦</label><input type="text" class="input_ty1 heightimg" name="" id="se2_sheight" value="768"><button class="se2_sreset" type="button"><span>初期化</span></button>
									<div class="se2_qe10_1"><input type="checkbox" checked="checked" name="" class="se2_srate" id="se2_srate"><label for="se2_srate">横縦の比率をキープ</label></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--//@lazyload_html-->
				<!-- 이미지 간단편집기 -->
			</div>
		</div>
		<!-- //입력 -->
		<!-- 입력창조절/ 모드전환 -->
		<div class="se2_conversion_mode">
			<button type="button" class="se2_inputarea_controller husky_seditor_editingArea_verticalResizer" title="入力窓のサイズ調節"><span>入力窓のサイズ調節</span></button>
			<ul class="se2_converter">
			<li class="active"><button type="button" class="se2_to_editor"><span>Editor</span></button></li>
			<li><button type="button" class="se2_to_html"><span>HTML</span></button></li>
			<li><button type="button" class="se2_to_text"><span>TEXT</span></button></li>
			</ul>
		</div>
		<!-- //입력창조절/ 모드전환 -->
		<hr>
		
	</div>
</div>
<!-- SE2 Markup End -->

</body>
</html>